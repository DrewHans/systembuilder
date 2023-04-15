#!/usr/bin/env bash


function check_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "This script requires $1 to be installed."
		echo "Please use your distribution's package manager to install it."
		exit 2
	fi
}

function check_not_root {
	if [[ $EUID -eq 0 ]]
	then
		echo "This script should not be run as root."
		exit 1
	fi
}

echo "Starting $0"

# safety checks
check_dependency "flatpak"
check_not_root

echo "Setting up user apps"

echo "Updating flatpak"
flatpak update --assumeyes
echo ""

echo "Running preinstall scripts"
for f in ./apps/user/*/preinstall.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running install scripts"
for f in ./apps/user/*/install.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "Running postinstall scripts"
for f in ./apps/user/*/postinstall.sh; do
	echo "Running ${f}"
	bash $f
	echo ""
done

echo "$0 has finished"
