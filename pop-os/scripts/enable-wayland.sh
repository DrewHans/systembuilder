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

echo "Enabling wayland on login screen"

patternMatch="^WaylandEnable=false$"
insertText="#WaylandEnable=false"
sedPattern="/$patternMatch/c\\$insertText"

sed -i "$sedPattern" /etc/gdm3/custom.conf

echo "$0 has finished"
