#!/usr/bin/env bash


function check_dependency {
	if ! command -v "$1" > /dev/null 2>&1
	then
		echo "This script requires $1 to be installed."
		exit 2
	fi
}

function check_not_root {
	if [[ $EUID -eq 0 ]]
	then
		echo "This script should not be run as root."
		exit 1
	fi
}

# safety checks
check_not_root
check_dependency "ssh"

echo "Starting $0"

if uname -a | grep OpenWrt
then
	echo "This script should not be run on an OpenWrt system."
	echo "This script should only be run on your computer."
	echo "Aborting."
	exit 3
fi

# if you don't have a public ssh key, create a new ssh keypair
if [ ! -f ~/.ssh/id_rsa.pub ]
then
	echo "Warning: you don't have a public ssh key (~/.ssh/id_rsa.pub)"

	check_dependency "ssh-keygen"

	echo "You need to generate a new ssh keypair."

	ssh-keygen

	echo ""
fi

# copy your public ssh key to the router
echo "Copying ~/.ssh/id_rsa.pub to the router..."

ssh root@192.168.1.1 "tee -a /etc/dropbear/authorized_keys" < ~/.ssh/id_rsa.pub

echo ""

echo "Verify you can SSH into router then harden security with these commands:"
echo '$ uci set dropbear.@dropbear[0].PasswordAuth="0"'
echo '$ uci set dropbear.@dropbear[0].RootPasswordAuth="0"'
echo '$ uci commit dropbear'
echo '$ /etc/init.d/dropbear restart'
echo '$ chmod -R u=rwX,go= /etc/dropbear'
echo ""

echo "$0 finished"
