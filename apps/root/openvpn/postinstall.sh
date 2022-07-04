#!/usr/bin/env bash


mkdir -p /etc/openvpn

# download and unzip nordvpn openvpn config files
wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip --directory-prefix=/etc/openvpn/
unzip /etc/openvpn/ovpn.zip -d /etc/openvpn/
rm /etc/openvpn/ovpn.zip

# setup auth file to hold credentials
touch /etc/openvpn/nordvpn_auth.txt
chown root:root /etc/openvpn/nordvpn_auth.txt
chmod 644 /etc/openvpn/nordvpn_auth.txt
echo "REPLACE_WITH_VPN_SERVICE_USERNAME" >> /etc/openvpn/nordvpn_auth.txt
echo "REPLACE_WITH_VPN_SERVICE_PASSWORD" >> /etc/openvpn/nordvpn_auth.txt
# note: the service username & password are different from the account login

# now you can start openvpn by running a command like:
# sudo openvpn \
# --config /etc/openvpn/ovpn_udp/us9632.nordvpn.com.udp.ovpn \
# --auth-user-pass /etc/openvpn/nordvpn_auth.txt \
# --log /etc/openvpn/log.txt \
# --daemon



