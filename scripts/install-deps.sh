#!/usr/bin/env bash


echo "Starting $0"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

echo "Checking dependencies"

# check for prerequisite programs

command -v dos2unix >/dev/null 2>&1 || {
    echo "Installing prerequisite program: dos2unix"
    apt install dos2unix --yes
    echo ""
}

command -v curl >/dev/null 2>&1 || {
    echo "Installing prerequisite program: curl"
    apt install curl --yes
    echo ""
}

command -v wget >/dev/null 2>&1 || {
    echo "Installing prerequisite program: wget"
    apt install wget --yes
    echo ""
}

echo "$0 has finished"
