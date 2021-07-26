#!/usr/bin/env bash

# set script variables
sudo_user_username=${SUDO_USER:-$USER} # user who ran this installer with sudo
gitserver="https://github.com/DrewHans"
dotfiles_repo_name="dotfiles"
scripts_repo_name="shellscripts"
dotfiles_repo_url="${gitserver}/${dotfiles_repo_name}"
scripts_repo_url="${gitserver}/${scripts_repo_name}"

# exit if not running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "You must run this script as root"
    exit 1
fi

echo "Refreshing apt"
sudo apt update

# check prerequisite programs installed
command -v dos2unix >/dev/null 2>&1 || {
    echo "Installing prerequisite program: dos2unix"
    sudo apt install dos2unix --yes
}

command -v curl >/dev/null 2>&1 || {
    echo "Installing prerequisite program: curl"
    sudo apt install curl --yes
}

command -v wget >/dev/null 2>&1 || {
    echo "Installing prerequisite program: wget"
    sudo apt install wget --yes
}

# check python is in path
command -v python >/dev/null 2>&1 || {
    echo "Symlinking python3 to python"
    sudo ln -s /usr/bin/python3 /usr/bin/python
}

# fix any file format problems in systembuilder scripts
find ./apps -name '*.sh' -type f -print0 | xargs -0 dos2unix --

# run preinstall scripts
for f in ./apps/*/preinstall.sh; do
    echo "Running ${f}"
    sudo bash $f
done

# download latest package info from apt repos
echo "Preinstall scripts finished; Refreshing apt"
sudo apt update

# install apps
for f in ./apps/*/install.sh; do
    echo "Running ${f}"
    sudo bash $f
done

# remove any obsolete packages
echo "Install scripts finished; Running autoremove"
sudo apt autoremove --yes

# create Code dir (as user) if it does not exist
[ -d ~/Code ] || {
    sudo -u ${sudo_user_username} \
        mkdir ~/Code
}

# check git is now installed
command -v git >/dev/null 2>&1 && {
    # install dotfiles (as user)
    sudo -u ${sudo_user_username} \
        git clone ${dotfiles_repo_url} ~/Code/${dotfiles_repo_name}

    dos2unix ~/Code/${dotfiles_repo_name}/installer.sh

    sudo -u ${sudo_user_username} \
        bash ~/Code/${dotfiles_repo_name}/installer.sh

    # install shellscripts (as user)
    sudo -u ${sudo_user_username} \
        git clone ${scripts_repo_url} ~/Code/${dotfiles_repo_name}

    dos2unix ~/Code/${scripts_repo_name}/installer.sh

    sudo -u ${sudo_user_username} \
        bash ~/Code/${scripts_repo_name}/installer.sh
}

# display helpful message if git is not found
command -v git >/dev/null 2>&1 || {
    echo "git command not found"
    echo "skipping ${dotfiles_repo_name} install"
    echo "skipping ${scripts_repo_name} install"
}

echo "systembuilder complete"

exit
