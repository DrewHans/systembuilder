#!/usr/bin/env bash

# For more information about this process, go to:
# https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-Login-Guide-U2F

# set temporary script variables
sudo_user=${SUDO_USER:-$USER} # user who ran this script with sudo

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# check prerequisite programs installed
command -v pamu2fcfg >/dev/null 2>&1 || {
    echo "Missing pamu2fcfg; aborting"
    exit 1
}

function associate_yubikey() {
    echo "Hit enter when you are ready to start:"
    read input
    echo "When your device begins flashing, touch the metal contact"
    sudo -u ${sudo_user} \
        pamu2fcfg >> /home/${sudo_user}/.config/Yubico/u2f_keys
    echo ""
}

echo "Starting $0"

# create Yubico dir (as user) if it does not exist
[ -d /home/${sudo_user}/.config/Yubico ] || {
    echo "Making Yubico directory to store u2f_keys"
    sudo -u ${sudo_user} \
        mkdir -p /home/${sudo_user}/.config/Yubico
    echo ""
}

echo "Making u2f_keys file to store yubikey association data"
sudo -u ${sudo_user} \
    touch /home/${sudo_user}/.config/Yubico/u2f_keys
echo ""

# make our Yubikeys work with U2F PAM module
echo "Please insert your first Yubikey into the computer"
associate_yubikey
echo "Please insert your second Yubikey into the computer"
associate_yubikey
echo "Please insert your third Yubikey into the computer"
associate_yubikey
echo "Yubikey association complete"
echo ""

# create /etc/Yubico dir if it does not exist
[ -d /etc/Yubico ] || {
    echo "Making /etc/Yubico directory to store u2f_keys file"
    mkdir -p /etc/Yubico
    echo ""
}

# copy u2f_keys file to a location outside of our encrypted HOME
echo "Moving u2f_keys file to /etc/Yubico"
sudo cp /home/${sudo_user}/.config/Yubico/u2f_keys /etc/Yubico/u2f_keys
sudo chmod 644 /etc/Yubico/u2f_keys
echo ""

# check gdm-password exists
[ -f /etc/pam.d/gdm-password ] || {
    echo "/etc/pam.d/gdm-password file not found; aborting"
    exit 1
}

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
