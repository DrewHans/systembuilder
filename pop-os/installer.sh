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

# install dependencies
sudo bash ./scripts/install-deps.sh  | tee -a ~/systembuilder_output.log

# create links
sudo bash ./scripts/create-links.sh  | tee -a ~/systembuilder_output.log

# set dns addresses
sudo bash ./scripts/set-dns-addresses.sh  | tee -a ~/systembuilder_output.log

# extend sudo timeout
sudo -v

# install root apps
sudo bash ./scripts/install-root-apps.sh  | tee -a ~/systembuilder_output.log

# extend sudo timeout
sudo -v

# install user apps
sudo -u ${SUDO_USER} bash ./scripts/install-user-apps.sh  | tee -a ~/systembuilder_output.log

# extend sudo timeout
sudo -v

# install user dotfiles
sudo -u ${SUDO_USER} bash ./scripts/install-dotfiles.sh  | tee -a ~/systembuilder_output.log

# install user shellscripts
sudo -u ${SUDO_USER} bash ./scripts/install-shellscripts.sh  | tee -a ~/systembuilder_output.log

# install user directories
sudo -u ${SUDO_USER} bash ./scripts/create-directories.sh  | tee -a ~/systembuilder_output.log

# extend sudo timeout
sudo -v

# set user gsettings
sudo -u ${SUDO_USER} bash ./scripts/set-gsettings.sh  | tee -a ~/systembuilder_output.log

echo "$0 finished"
