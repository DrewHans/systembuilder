#!/usr/bin/env bash


function check_is_root {
	if [[ $EUID -ne 0 ]]
	then
		echo "This script must be run as root."
		exit 1
	fi
}

echo "Starting $0"

# safety checks
check_is_root

# Step 0: install OpenRazer & Polychromatic (optional but is useful)
sudo add-apt-repository ppa:openrazer/stable
sudo apt update
sudo apt install openrazer-meta

sudo add-apt-repository ppa:polychromatic/stable
sudo apt update
sudo apt install polychromatic

# Step 1: install nvidia drivers
sudo apt-add-repository -y ppa:system76-dev/stable
sudo apt-get update
sudo apt install system76-driver-nvidia --yes

# Step 2: enable nvidia direct rendering manager by adding this kernel option
sudo kernelstub -a "nvidia-drm.modeset=1"

# Step 3: make nvidia driver load faster by embedding it into initrd
echo 'nvidia' | sudo tee -a /etc/initramfs-tools/modules
echo 'nvidia-modeset' | sudo tee -a /etc/initramfs-tools/modules
echo 'nvidia-drm' | sudo tee -a /etc/initramfs-tools/modules

# Step 4: deny fallback to nouveau driver (egpu is not compatible with it)
sudo touch /etc/modprobe.d/blacklist-nvidia-nouveau.conf
echo 'blacklist nouveau' | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf
echo 'options nouveau modeset=0' | sudo tee -a /etc/modprobe.d/blacklist-nvidia-nouveau.conf

# Step 5: install egpu-switcher to autogenerate required x11 config files
wget https://github.com/hertg/egpu-switcher/releases/download/0.19.0/egpu-switcher-amd64
sudo cp egpu-switcher-amd64 /opt/egpu-switcher
sudo chmod 755 /opt/egpu-switcher
sudo ln -s /opt/egpu-switcher /usr/bin/egpu-switcher
sudo egpu-switcher enable

# Step 6: update your system's initramfs (required for steps 3 & 4)
sudo update-initramfs -u

# Step 7: shutdown in one minute
sudo reboot -r +1

# Step 8: the extra stupid step required for using X11 with the eGPU
echo "During reboot, make sure to hit ESC before the OS loads"
echo "Once in the firmware, plug in the Thunderbolt cable"
echo "Then after the eGPU starts up, you can select the boot disk"
echo "When you make it to the login screen, you should see output on the external monitors."

echo "WARNING: if you try to plug in the Thunderbolt cable after boot, the eGPU won't show anything on the external monitors."
echo "         I don't know why, but that's just how it is."

echo "$0 finished."

# see https://wiki.archlinux.org/title/NVIDIA for more detailed information