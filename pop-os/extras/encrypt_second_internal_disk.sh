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
check_dependency "parted"
check_dependency "cryptsetup"
check_is_root



### Prep disk
# step 1: get the device name ( example: /dev/nvme1n1 )
sudo parted -l

# step 2: create a new gpt partition table on the disk
sudo parted /dev/nvme1n1 mklabel gpt

# step 3: create a new partition on the disk
sudo parted -a opt /dev/nvme1n1 mkpart primary ext4 0% 100%

# step 4: verify your new partition
sudo parted -l



### Setup disk encryption
# step 1: encrypt the partition
sudo cryptsetup --iter-time 5000 --use-random luksFormat --type luks2 /dev/nvme1n1p1

# step 2: open the encrypted partition (mounts inside /dev/mapper/ directory)
sudo cryptsetup open /dev/nvme1n1p1 local_storage

# step 3: create a new filesystem on the decrypted partition
sudo mkfs.ext4 /dev/mapper/local_storage



### Setup automatic disk decryption at startup
# step 1: create a keyfile for decryption
sudo dd if=/dev/random of=/root/.local_storage-keyfile bs=1024 count=4

# step 2: change keyfile permissions for better security
sudo chmod 0400 /root/.local_storage-keyfile

# step 3: tell cryptsetup to allow keyfile to decrypt the encrypted partition
sudo cryptsetup luksAddKey /dev/nvme1n1p1 /root/.local_storage-keyfile

# step 4: get the UUID of /dev/nvme1n1p1
sudo blkid | grep /dev/nvme1n1p1

# step 5: add a line to /etc/crypttab to auto decrypt using keyfile on startup
sudo echo "" >> /etc/crypttab
sudo echo "local_storage UUID=YOUR-DISK-UUID-GOES-HERE /root/.local_storage-keyfile luks,discard" >> /etc/crypttab



echo "Finished"