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

echo "Starting $0"

# safety checks
check_dependency "apt"
check_dependency "git"
check_is_root

cwd=$(pwd)

cd /home/${USER}/Code

sudo apt update

echo "Installing flashrom"
sudo apt install flashrom --yes

echo "Installing build-essential & other build tools"
sudo apt install \
	build-essential \
	libftdi1 \
	libftdi-dev \
	libusb-dev \
	libpci-dev \
	m4 \
	bison \
	flex \
	libncurses5-dev \
	libncurses5 \
	pciutils \
	usbutils \
	libpci-dev \
	libusb-dev \
	zlib1g-dev \
	gnat-4.9

echo "Downloading the coreboot git repo"
git clone --recurse-submodules https://review.coreboot.org/coreboot.git ~/coreboot

echo "Downloading the me_cleaner git repo"
git clone https://github.com/corna/me_cleaner ~/me_cleaner

echo "Compiling/installing coreboot's ifdtool"
cd ~/coreboot/util/ifdtool
make && sudo make install

echo "Setup complete"

# Online references:
# https://michaelmob.com/post/coreboot-thinkpad-x220/
# https://www.coreboot.org/Board:lenovo/x220
# https://www.youtube.com/watch?v=ExQKOtZhLBM
# https://tylercipriani.com/blog/2016/11/13/coreboot-on-the-thinkpad-x220-with-a-raspberry-pi/
