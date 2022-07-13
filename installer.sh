#!/usr/bin/env bash

# set temporary script variables
git_user_name="DrewHans"
dotfiles_repo_name="dotfiles"
scripts_repo_name="shellscripts"
dotfiles_repo_url="https://github.com/${git_user_name}/${dotfiles_repo_name}.git"
scripts_repo_url="https://github.com/${git_user_name}/${scripts_repo_name}.git"
cwd=$(pwd)

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# check prerequisite programs installed
command -v dos2unix >/dev/null 2>&1 || {
    echo "Installing prerequisite program: dos2unix"
    apt install dos2unix --yes
    echo ""
}

command -v curl >/dev/null 2>&1 || {
    echo "Installing prerequisite program: curl"
    apt install curl --yes
    echo ""
}

command -v wget >/dev/null 2>&1 || {
    echo "Installing prerequisite program: wget"
    apt install wget --yes
    echo ""
}

# check python is in path
command -v python >/dev/null 2>&1 || {
    echo "Symlinking python3 to python"
    ln -s /usr/bin/python3 /usr/bin/python
    echo ""
}

# check pip is in path
command -v pip >/dev/null 2>&1 || {
    echo "Symlinking pip3 to pip"
    ln -s /usr/bin/pip3 /usr/bin/pip
    echo ""
}

echo "Running dos2unix on all scripts in apps directory"
find ./apps -name '*.sh' -type f -print0 | xargs -0 dos2unix --
echo ""

###############################################################################
########## Root Apps
echo "Setting up root apps (sudo required)"

echo "Running preinstall scripts"
for f in ./apps/root/*/preinstall.sh; do
    echo "Running ${f}"
    sudo bash $f
    echo ""
done

echo "Running apt update"
apt update
echo ""

echo "Running install scripts"
for f in ./apps/root/*/install.sh; do
    echo "Running ${f}"
    sudo bash $f
    echo ""
done

echo "Running postinstall scripts"
for f in ./apps/root/*/postinstall.sh; do
    echo "Running ${f}"
    sudo bash $f
    echo ""
done

echo "Running apt clean"
apt clean --yes
echo ""

echo "Running apt autoremove"
apt autoremove --yes
echo ""


###############################################################################
########## User Apps
echo "Setting up user apps for ${SUDO_USER}"

sudo -u ${SUDO_USER} flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Updating flatpak"
sudo -u ${SUDO_USER} flatpak update --assumeyes
echo ""

echo "Running preinstall scripts"
for f in ./apps/user/*/preinstall.sh; do
    echo "Running ${f}"
    sudo -u ${SUDO_USER} bash $f
    echo ""
done

echo "Running install scripts"
for f in ./apps/user/*/install.sh; do
    echo "Running ${f}"
    sudo -u ${SUDO_USER} bash $f
    echo ""
done

echo "Running postinstall scripts"
for f in ./apps/user/*/postinstall.sh; do
    echo "Running ${f}"
    sudo -u ${SUDO_USER} bash $f
    echo ""
done

###############################################################################

# setup Code dir
sudo -u ${SUDO_USER} mkdir -p /home/${SUDO_USER}/Code
chmod 755 /home/${SUDO_USER}/Code

# check if git is installed
command -v git >/dev/null 2>&1 && {

    # install dotfiles (as user)
    echo "Cloning ${dotfiles_repo_name}"
    sudo -u ${SUDO_USER} git clone ${dotfiles_repo_url}
    cd ./${dotfiles_repo_name}
    dos2unix ./installer.sh
    echo "Running ${dotfiles_repo_name} installer.sh"
    sudo -u ${SUDO_USER} bash ./installer.sh
    echo ""

    # install shellscripts (as SUDO_USER)
    echo "Cloning ${scripts_repo_name}"
    sudo -u ${SUDO_USER} git clone ${scripts_repo_url}
    cd ./${scripts_repo_name}
    dos2unix ./installer.sh
    echo "Running ${scripts_repo_name} installer.sh"
    sudo -u ${SUDO_USER} bash ./installer.sh
    echo ""

    # return to original working directory
    cd $cwd
}

# display helpful message if git is not found
command -v git >/dev/null 2>&1 || {
    echo "git command not found"
    echo "skipping ${dotfiles_repo_name} install"
    echo "skipping ${scripts_repo_name} install"
    echo ""
}

# set the system's DNS Addresses:
### Cloudflare's 1.1.1.1 ipv4 & ipv6 addresses
### QuadNine's 9.9.9.9 ipv4 address
for f in /etc/NetworkManager/system-connections; do
    echo "Setting DNS addresses"
    sudo sed -i '/^\[ipv4\]$/,/^\[/ s/^dns=.*$/dns=1.1.1.1;1.0.0.1;9.9.9.9;/m' "$f"
    sudo sed -i '/^\[ipv6\]$/,/^\[/ s/^dns=.*$/dns=2606:4700:4700::1111;2606:4700:4700::1001;/m' "$f"
    echo ""
done

echo "systembuilder complete"

exit
