#!/usr/bin/env bash


echo "Starting $0"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

echo "Setting DNS addresses (sudo required)"


if [[ $(ls -1q /etc/NetworkManager/system-connections | wc -l) -eq 0 ]]; then
    echo "Error: there are no files in /etc/NetworkManager/system-connections"
    echo "DNS Addresses have not been set"
fi

if [[ $(ls -1q /etc/NetworkManager/system-connections | wc -l) -ne 0 ]]; then
    # set ipv4 dns addresses
    find /etc/NetworkManager/system-connections -type f -exec \
        sed -i -e '/^\[ipv4\]$/,/^\[/ s/^dns=.*$/dns=1.1.1.1;1.0.0.1;9.9.9.9;149.112.112.112;/m' {} \;

    # set ipv6 dns addresses
    find /etc/NetworkManager/system-connections -type f -exec \
        sed -i -e '/^\[ipv6\]$/,/^\[/ s/^dns=.*$/dns=2606:4700:4700::1111;2606:4700:4700::1001;2620:fe::fe;2620:fe::9;/m' {} \;
fi

echo "$0 has finished"
