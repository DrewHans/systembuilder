#!/usr/bin/env bash


echo "Starting $0"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# check for missing links

command -v python >/dev/null 2>&1 || {
    echo "Symlinking python3 to python"
    ln -s /usr/bin/python3 /usr/bin/python
    echo ""
}

command -v pip >/dev/null 2>&1 || {
    echo "Symlinking pip3 to pip"
    ln -s /usr/bin/pip3 /usr/bin/pip
    echo ""
}

echo "$0 has finished"
