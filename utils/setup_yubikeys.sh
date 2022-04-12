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

# backup pam.d/gdm-password before modification
echo "Backing up the system's pam.d/gdm-password file"
sudo cp /etc/pam.d/gdm-password /etc/pam.d/gdm-password.backup
echo ""

# if Yubikey is not already required for gdm login
if ! grep -qF "authfile=/etc/Yubico/u2f_keys" /etc/pam.d/gdm-password; then
    # require a Yubikey for gdm login
    echo "Updating up the system's pam.d/gdm-password file"
    insertstr="auth	required	pam_u2f.so	authfile=/etc/Yubico/u2f_keys"
    sudo sed -i "/^@include common-auth/a $insertstr" /etc/pam.d/gdm-password
    echo ""
fi


# check pam.d/login exists
[ -f /etc/pam.d/login ] || {
    echo "/etc/pam.d/login file not found; aborting"
    exit 1
}

# backup pam.d/login before modification
echo "Backing up the system's pam.d/login file"
sudo cp /etc/pam.d/login /etc/pam.d/login.backup
echo ""

# if Yubikey is not already required for tty login
if ! grep -qF "authfile=/etc/Yubico/u2f_keys" /etc/pam.d/login; then
    # require a Yubikey for tty login
    echo "Updating up the system's pam.d/login file"
    insertstr="auth	required	pam_u2f.so	authfile=/etc/Yubico/u2f_keys"
    sudo sed -i "/^@include common-auth/a $insertstr" /etc/pam.d/login
    echo ""
fi


echo "You will now need a Yubikey to login to gdm and tty"
echo ""
