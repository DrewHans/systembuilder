#!/usr/bin/env bash


echo "Starting $0"

# set temporary script variables
repo_name="shellscripts"
shellscripts_repo_url="https://github.com/DrewHans/${repo_name}.git"
cwd=$(pwd)

# exit if running as root
if [[ $(/usr/bin/id -u) -eq 0 ]]; then
    echo "Error: You should not run this script as root"
    exit 1
fi

echo "Installing $repo_name"

# check if git is installed
command -v git >/dev/null 2>&1 && {
    echo "Cloning ${repo_name}"
    git clone ${shellscripts_repo_url}

    cd ./${repo_name}

    echo "Running ${repo_name} installer.sh"
    bash ./installer.sh
    echo ""

    # return to original working directory
    cd $cwd
}

# display helpful message if git is not found
command -v git >/dev/null 2>&1 || {
    echo "git command not found"
    echo "skipping ${repo_name} install"
    echo ""
}

echo "$0 has finished"
