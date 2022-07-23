#!/usr/bin/env bash


echo "Starting $0"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# install dependencies
sudo bash ./scripts/install-deps.sh

# create links
sudo bash ./scripts/create-links.sh

# set dns addresses
sudo bash ./scripts/set-dns-addresses.sh

# extend sudo timeout
sudo -v

# install root apps
sudo bash ./scripts/install-root-apps.sh

# extend sudo timeout
sudo -v

# install user apps
sudo -u ${SUDO_USER} bash ./scripts/install-user-apps.sh

# extend sudo timeout
sudo -v

# install configuration files
sudo -u ${SUDO_USER} bash ./scripts/install-dotfiles.sh

# install scripts
sudo -u ${SUDO_USER} bash ./scripts/install-shellscripts.sh

# install user directories
sudo -u ${SUDO_USER} bash ./scripts/create-directories.sh

echo "systembuilder complete"
