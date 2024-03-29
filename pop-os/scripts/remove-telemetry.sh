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

echo "Removing telemetry (if present)..."
apt purge apport --yes
apt remove popularity-contest --yes
echo ""

echo "Removing installed packages that are no longer required..."
apt autoremove --yes
echo ""

echo "$0 has finished"
