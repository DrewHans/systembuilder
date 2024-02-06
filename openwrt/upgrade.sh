#!/usr/bin/env sh


echo "Starting $0"

if ! uname -a | grep OpenWrt
then
	echo "This script should only be run on OpenWrt systems."
	echo "Aborting."
	exit 1
fi

echo "This script should be run on the router after upgrading the firmware"
echo ""

# reset DNS (because https-dns-proxy gets broken after upgrading the firmware)
echo "Resetting DNS to Cloudflare & Quad9"

uci set network.wan.peerdns="0"
uci set network.wan.dns="1.1.1.1 1.0.0.1 9.9.9.9 149.112.112.112"

uci set network.wan6.peerdns="0"
uci set network.wan6.dns="2606:4700:4700::1111 2606:4700:4700::1001 2620:fe::fe 2620:fe::9"

uci commit network
service network reload

echo ""

echo "Now you can reinstall https-dns-proxy and reconfigure (see router.sh)"

echo "$0 finished"
