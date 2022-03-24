#!/usr/bin/env bash

sudo_user_username=${SUDO_USER:-$USER} # user who ran this script with sudo
cwd=$(pwd)

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# check prerequisite programs installed
command -v git >/dev/null 2>&1 || {
    echo "git not found; aborting"
    exit 1
}

cd /home/${sudo_user_username}/Code

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
