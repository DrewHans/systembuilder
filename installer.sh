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

echo ""

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

echo ""

# run preinstall scripts
for f in ./apps/*/preinstall.sh; do
    echo "Running ${f}"
    sudo bash $f
done

echo ""

# download latest package info from apt repos
echo "Preinstall scripts finished; Refreshing apt"
sudo apt update

echo ""

# install apps
for f in ./apps/*/install.sh; do
    echo "Running ${f}"
    sudo bash $f
done

echo ""

# remove any obsolete packages
echo "Install scripts finished; Running autoremove"
sudo apt autoremove --yes

echo ""

# create Code dir (as user) if it does not exist
[ -d /home/${sudo_user_username}/Code ] || {
    echo "Making Code directory for ${sudo_user_username}"
    sudo -u ${sudo_user_username} \
        mkdir /home/${sudo_user_username}/Code
}

echo ""

# check git is now installed
command -v git >/dev/null 2>&1 && {
    # install dotfiles (as user)
    echo "Cloning ${dotfiles_repo_name}"
    sudo -u ${sudo_user_username} \
        git clone ${dotfiles_repo_url} /home/${sudo_user_username}/Code/${dotfiles_repo_name}

    echo "Fixing ${dotfiles_repo_name} files with dos2unix"
    dos2unix /home/${sudo_user_username}/Code/${dotfiles_repo_name}/installer.sh

    echo ""
    echo "Running ${dotfiles_repo_name} installer.sh"
    sudo -u ${sudo_user_username} \
        bash /home/${sudo_user_username}/Code/${dotfiles_repo_name}/installer.sh

    echo ""

    # install shellscripts (as user)
    echo "Cloning ${scripts_repo_name}"
    sudo -u ${sudo_user_username} \
        git clone ${scripts_repo_url} /home/${sudo_user_username}/Code/${dotfiles_repo_name}

    echo "Fixing ${scripts_repo_name} files with dos2unix"
    dos2unix /home/${sudo_user_username}/Code/${scripts_repo_name}/installer.sh

    echo "Running ${scripts_repo_name} installer.sh"
    sudo -u ${sudo_user_username} \
        bash /home/${sudo_user_username}/Code/${scripts_repo_name}/installer.sh
}

# display helpful message if git is not found
command -v git >/dev/null 2>&1 || {
    echo "git command not found"
    echo "skipping ${dotfiles_repo_name} install"
    echo "skipping ${scripts_repo_name} install"
}

echo "systembuilder complete"

exit
