#!/usr/bin/env bash


# For more information about this process, go to:
# https://support.yubico.com/hc/en-us/articles/360016649099-Ubuntu-Linux-Login-Guide-U2F

function associate_yubikey() {
	echo "Hit enter when you are ready to start:"
	read input
	echo "When your device begins flashing, touch the metal contact"
	sudo -u ${USER} pamu2fcfg >> /home/${USER}/.config/Yubico/u2f_keys
	echo ""
}

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

# safety checks
check_is_root

echo "Starting $0"

if ! command -v "pamu2fcfg" > /dev/null 2>&1
then
	echo "Warning: pamu2fcfg not found!"
	echo "Installing libpam-yubico and libpan-u2f..."
	apt install libpam-yubico libpam-u2f --yes
	echo ""
fi

# create Yubico dir (as user) if it does not exist
if [ ! -d /home/${USER}/.config/Yubico ]
then
	echo "Making Yubico directory to store u2f_keys"
	sudo -u ${USER} mkdir -p /home/${USER}/.config/Yubico
	echo ""
fi

echo "Making u2f_keys file to store yubikey association data"
sudo -u ${USER} touch /home/${USER}/.config/Yubico/u2f_keys
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
if [ ! -d /etc/Yubico ]
then
	echo "Making /etc/Yubico directory to store u2f_keys file"
	mkdir -p /etc/Yubico
	echo ""
fi

# copy u2f_keys file to a location outside of our encrypted HOME
echo "Moving u2f_keys file to /etc/Yubico"
sudo cp /home/${USER}/.config/Yubico/u2f_keys /etc/Yubico/u2f_keys
sudo chmod 644 /etc/Yubico/u2f_keys
echo ""

# check gdm-password exists
if [ ! -f /etc/pam.d/gdm-password ]
then
	echo "/etc/pam.d/gdm-password file not found; aborting"
	exit 1
fi

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
if [ ! -f /etc/pam.d/login ]
then
	echo "/etc/pam.d/login file not found; aborting"
	exit 1
fi

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
