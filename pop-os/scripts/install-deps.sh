#!/usr/bin/env bash


function install_missing_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "Installing prerequisite program: $1"
		apt install "$1" --yes
		echo ""
	fi
}

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

echo "Checking dependencies"

# check for prerequisite programs
install_missing_dependency "dos2unix"
install_missing_dependency "curl"
install_missing_dependency "wget"

echo "$0 has finished"
