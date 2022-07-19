#!/usr/bin/env bash


echo "Starting $0"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# install dependencies
sudo bash ./scripts/install-deps.sh

# install links
sudo bash ./scripts/install-links.sh

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

# install configuration files
sudo -u ${SUDO_USER} bash ./scripts/install-dotfiles.sh

# install scripts
sudo -u ${SUDO_USER} bash ./scripts/install-shellscripts.sh

# create Code dir for storing projects
sudo -u ${SUDO_USER} mkdir -p /home/${SUDO_USER}/Code
chmod 755 /home/${SUDO_USER}/Code

echo "systembuilder complete"
