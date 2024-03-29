#!/usr/bin/env sh


echo "Starting $0"

if ! uname -a | grep OpenWrt
then
	echo "This script should only be run on OpenWrt systems."
	echo "Aborting."
	exit 1
fi

echo "Updating list of available packages..."
echo ""

opkg update

echo ""

echo "Installing packages for DNS Over HTTPS..."
echo ""

opkg install https-dns-proxy
opkg install luci-app-https-dns-proxy

echo ""

echo "Restarting rpc daemon to make new services show up in LuCI..."

/etc/init.d/rpcd restart

echo ""

echo "Configuring https-dns-proxy..."

echo "Backing up default settings..."

uci show > default_router_settings.txt

echo ""

echo "Applying preferred https-dns-proxy settings..."

# prevent DNS highjacking (allow users to use their own DNS, if defined)
uci set https-dns-proxy.config.force_dns='0'

# set Quad9 as primary DOH provider
uci set https-dns-proxy.@https-dns-proxy[0]=https-dns-proxy
uci set https-dns-proxy.@https-dns-proxy[0].listen_addr='127.0.0.1'
uci set https-dns-proxy.@https-dns-proxy[0].listen_port='5053'
uci set https-dns-proxy.@https-dns-proxy[0].user='nobody'
uci set https-dns-proxy.@https-dns-proxy[0].group='nogroup'
uci set https-dns-proxy.@https-dns-proxy[0].resolver_url='https://dns.quad9.net/dns-query'
uci set https-dns-proxy.@https-dns-proxy[0].bootstrap_dns='9.9.9.9,149.112.112.112,2620:fe::fe,2620:fe::9'

# set Cloudflare as secondary DOH provider
uci set https-dns-proxy.@https-dns-proxy[1]=https-dns-proxy
uci set https-dns-proxy.@https-dns-proxy[1].listen_addr='127.0.0.1'
uci set https-dns-proxy.@https-dns-proxy[1].user='nobody'
uci set https-dns-proxy.@https-dns-proxy[1].group='nogroup'
uci set https-dns-proxy.@https-dns-proxy[1].resolver_url='https://cloudflare-dns.com/dns-query'
uci set https-dns-proxy.@https-dns-proxy[1].listen_port='5054'
uci set https-dns-proxy.@https-dns-proxy[1].bootstrap_dns='1.1.1.1,1.0.0.1,2606:4700:4700::1111,2606:4700:4700::1001'

# set Google as fallback DOH provider
uci set https-dns-proxy.@https-dns-proxy[2]=https-dns-proxy
uci set https-dns-proxy.@https-dns-proxy[2].listen_addr='127.0.0.1'
uci set https-dns-proxy.@https-dns-proxy[2].user='nobody'
uci set https-dns-proxy.@https-dns-proxy[2].group='nogroup'
uci set https-dns-proxy.@https-dns-proxy[2].resolver_url='https://dns.google/dns-query'
uci set https-dns-proxy.@https-dns-proxy[2].listen_port='5055'
uci set https-dns-proxy.@https-dns-proxy[2].bootstrap_dns='8.8.8.8,8.8.4.4,2001:4860:4860::8888,2001:4860:4860::8844'

uci commit https-dns-proxy

# delete any configuration created during reinstall (after upgrading openwrt)
uci delete https-dns-proxy-opkg.config
uci delete https-dns-proxy-opkg.@https-dns-proxy
while uci -q delete https-dns-proxy-opkg.@https-dns-proxy[0]; do :; done

# delete default config file if it was created during reinstall
rm /etc/config/https-dns-proxy-opkg

echo "Restarting https-dns-proxy service (to load new configuration)..."
/etc/init.d/https-dns-proxy restart

echo ""

echo "Hardening security..."

# harden security: disabling dropbear password authentication
uci set dropbear.@dropbear[0].PasswordAuth="0"
uci set dropbear.@dropbear[0].RootPasswordAuth="0"
uci commit dropbear
/etc/init.d/dropbear restart

# harden security: set correct permissions for dropbear files
chmod -R u=rwX,go= /etc/dropbear

echo ""

echo "$0 finished"
