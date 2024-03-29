#!/usr/bin/env bash


function check_is_root {
	if [[ $EUID -ne 0 ]]
	then
		echo "This script must be run as root."
		exit 1
	fi
}

# safety checks
check_is_root

echo "Starting $0"

mkdir -p /var/lib/gdm3/.config/

sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/monitors.xml
sudo chown gdm:gdm /var/lib/gdm3/.config/monitors.xml

echo "$0 has finished"
