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

if command -v "apt" > /dev/null 2>&1
then
	apt update && apt upgrade --yes
	apt autoremove --yes
else
	echo "apt is not installed, skipping"
fi

echo "$0 finished"
