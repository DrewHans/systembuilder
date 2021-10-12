#!/usr/bin/env bash

# For more information about this process, go to:
# https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-Login-Guide-U2F

# set temporary script variables
sudo_user_username=${SUDO_USER:-$USER} # user who ran this script with sudo

# check prerequisite programs installed
command -v pamu2fcfg >/dev/null 2>&1 || {
    echo "Missing pamu2fcfg; aborting"
    exit 1
}

function associate_yubikey() {
    echo "Hit enter when you are ready to start:"
    read input
    echo "When your device begins flashing, touch the metal contact"
    pamu2fcfg >> /home/${sudo_user_username}/.config/Yubico/u2f_keys
    echo ""
}

# create Yubico dir (as user) if it does not exist
[ -d /home/${sudo_user_username}/.config/Yubico ] || {
    echo "Making Yubico directory to store u2f_keys"
    sudo -u ${sudo_user_username} \
        mkdir -p /home/${sudo_user_username}/.config/Yubico
    echo ""
}

# make our Yubikeys work with U2F PAM module
echo "Please insert your first Yubikey into the computer"
associate_yubikey
echo "Please insert your second Yubikey into the computer"
associate_yubikey
echo "Please insert your third Yubikey into the computer"
associate_yubikey
echo "Yubikey association complete"
echo ""

# copy u2f_keys file to a location outside of our encrypted HOME
echo "Moving u2f_keys file to a safer location"
sudo mkdir /etc/Yubico
sudo cp /home/${sudo_user_username}/.config/Yubico/u2f_keys /etc/Yubico/u2f_keys
sudo chmod 644 /etc/Yubico/u2f_keys
echo ""

# backup gdm-password before modification
echo "Backing up the system's PAM file"
sudo cp /etc/pam.d/gdm-password /etc/pam.d/gdm-password.backup
echo ""

# require a Yubikey for login
echo "Updating up the system's PAM file"
insertstr="auth	required	pam_u2f.so	authfile=/etc/Yubico/u2f_keys"
sudo sed "/^@include common-auth/a $insertstr" /etc/pam.d/gdm-password >> /etc/pam.d/gdm-password
echo ""

echo "Finished; you will now need a Yubikey to login"
echo "Double check /etc/pam.d/gdm-password before logging out"
echo ""

# TODO: test this in a VM before enabling
# update /etc/pam.d/login
# requires a Yubikey for TTY terminal (stop an attacker from bypassing Yubikey)
# echo "Updating up the system's TTY terminal PAM file"
# insertstr="auth	required	pam_u2f.so	authfile=/etc/Yubico/u2f_keys"
# sed "/^@include common-auth.*/i after=$insertstr" /etc/pam.d/login
# echo ""
