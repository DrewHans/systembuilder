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

# install prerequisite programs
sudo apt install dos2unix --yes

# check prerequisite programs installed
command -v dos2unix >/dev/null 2>&1 || {
    echo >&2 "dos2unix is not installed"
    exit 1
}

# check python is in path
command -v python >/dev/null 2>&1 || {
    # if not found, symlink python3
    sudo ln -s /usr/bin/python3 /usr/bin/python
}

# fix any file format problems in scripts
find ./apps -name '*.sh' -type f -print0 | xargs -0 dos2unix --

# run preinstall scripts
for f in ./apps/*/preinstall.sh; do
    sudo bash $f
done

# download latest package info from apt repos
sudo apt update

# install apps
for f in ./apps/*/install.sh; do
    sudo bash $f
done

# remove any obsolete packages
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
