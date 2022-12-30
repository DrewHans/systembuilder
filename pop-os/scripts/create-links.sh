#!/usr/bin/env bash


function check_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "This script requires $1 to be installed."
		echo "Please use your distribution's package manager to install it."
		exit 2
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

check_dependency "python3"

if ! command -v "python" > /dev/null 2>&1
then
	echo "Symlinking python3 to python"
	ln -s /usr/bin/python3 /usr/bin/python
	echo ""
fi

check_dependency "pip3"

if ! command -v "pip" > /dev/null 2>&1
then
	echo "Symlinking pip3 to pip"
	ln -s /usr/bin/pip3 /usr/bin/pip
	echo ""
fi

echo "$0 has finished"
