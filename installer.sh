#!/usr/bin/env bash

# set temporary script variables
sudo_user_username=${SUDO_USER:-$USER} # user who ran this installer with sudo
gitserver="https://github.com/DrewHans"
dotfiles_repo_name="dotfiles"
scripts_repo_name="shellscripts"
dotfiles_repo_url="${gitserver}/${dotfiles_repo_name}"
scripts_repo_url="${gitserver}/${scripts_repo_name}"
cwd=$(pwd)

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Error: You must run this script as root"
    exit 1
fi

# check prerequisite programs installed
command -v dos2unix >/dev/null 2>&1 || {
    echo "Installing prerequisite program: dos2unix"
    sudo apt install dos2unix --yes
    echo ""
}

command -v curl >/dev/null 2>&1 || {
    echo "Installing prerequisite program: curl"
    sudo apt install curl --yes
    echo ""
}

command -v wget >/dev/null 2>&1 || {
    echo "Installing prerequisite program: wget"
    sudo apt install wget --yes
    echo ""
}

# check python is in path
command -v python >/dev/null 2>&1 || {
    echo "Symlinking python3 to python"
    sudo ln -s /usr/bin/python3 /usr/bin/python
    echo ""
}

# check pip is in path
command -v pip >/dev/null 2>&1 || {
    echo "Symlinking pip3 to pip"
    sudo ln -s /usr/bin/pip3 /usr/bin/pip
    echo ""
}

echo "Running dos2unix on all scripts"
find ./apps -name '*.sh' -type f -print0 | xargs -0 dos2unix --
echo ""

echo "Running apt update"
sudo apt update
echo ""

echo "Updating flatpak"
sudo -u ${sudo_user_username} flatpak update --assumeyes
echo ""

echo "Running preinstall scripts"
for f in ./apps/*/preinstall.sh; do
    echo "Running ${f}"
    sudo bash $f
    echo ""
done

echo "Running apt update"
sudo apt update
echo ""

echo "Running install scripts"
for f in ./apps/*/install.sh; do
    echo "Running ${f}"
    sudo bash $f
    echo ""
done

echo "Running postinstall scripts"
for f in ./apps/*/postinstall.sh; do
    echo "Running ${f}"
    sudo bash $f
    echo ""
done

echo "Running apt clean"
sudo apt clean --yes
echo ""

echo "Running apt autoremove"
sudo apt autoremove --yes
echo ""

# create Code dir (as user) if it does not exist
[ -d /home/${sudo_user_username}/Code ] || {
    echo "Making Code directory for ${sudo_user_username} as ${sudo_user_username}"
    sudo -u ${sudo_user_username} \
        mkdir /home/${sudo_user_username}/Code
    echo ""
}

# check if git is installed
command -v git >/dev/null 2>&1 && {

    cd /home/${sudo_user_username}/Code

    # install dotfiles (as user)
    echo "Cloning ${dotfiles_repo_name} as ${sudo_user_username}"
    sudo -u ${sudo_user_username} \
        git clone ${dotfiles_repo_url}

    cd ./${dotfiles_repo_name}
    dos2unix ./installer.sh

    echo "Running ${dotfiles_repo_name} installer.sh as ${sudo_user_username}"
    sudo -u ${sudo_user_username} \
        bash ./installer.sh
    echo ""

    cd /home/${sudo_user_username}/Code

    # install shellscripts (as user)
    echo "Cloning ${scripts_repo_name} as ${sudo_user_username}"
    sudo -u ${sudo_user_username} \
        git clone ${scripts_repo_url}

    cd ./${scripts_repo_name}
    dos2unix ./installer.sh

    echo "Running ${scripts_repo_name} installer.sh as ${sudo_user_username}"
    sudo -u ${sudo_user_username} \
        bash ./installer.sh
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

# stop computer from automatically fetching updates on login
systemctl stop \
    apt-daily.timer \
    apt-daily.service \
    apt-daily-upgrade.timer \
    apt-daily-upgrade.service

systemctl disable \
    apt-daily.timer \
    apt-daily.service \
    apt-daily-upgrade.timer \
    apt-daily-upgrade.service

echo "systembuilder complete"

exit
