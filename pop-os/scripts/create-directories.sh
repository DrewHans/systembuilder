#!/usr/bin/env bash


function check_not_root {
	if [[ $EUID -eq 0 ]]
	then
		echo "This script should not be run as root."
		exit 1
	fi
}

echo "Starting $0"

# safety checks
check_not_root

# create Apps dir for storing appimage files
mkdir -p ~/Apps
chmod 755 ~/Apps

# create Code dir for storing git repos
mkdir -p ~/Code
chmod 755 ~/Code

echo "$0 has finished"
