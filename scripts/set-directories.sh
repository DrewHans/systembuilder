#!/usr/bin/env bash


echo "Starting $0"

# exit if running as root
if [[ $(/usr/bin/id -u) -eq 0 ]]; then
    echo "Error: You should not run this script as root"
    exit 1
fi

# create Apps dir for storing appimage files
mkdir -p ~/Apps
chmod 755 ~/Apps

# create Code dir for storing git repos
mkdir -p ~/Code
chmod 755 ~/Code

echo "$0 has finished"
