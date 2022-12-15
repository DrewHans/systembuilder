#!/usr/bin/env bash


function check_not_root {
	if [[ $EUID -eq 0 ]]
	then
		echo "This script should not be run as root."
		exit 1
	fi
}

# safety checks
check_not_root

echo "Starting $0"

# set temporary script variables
repo_name="shellscripts"
shellscripts_repo_url="https://github.com/DrewHans/${repo_name}.git"
cwd=$(pwd)

echo "Installing $repo_name"

if command -v "git" > /dev/null 2>&1
then
	echo "Cloning ${repo_name}"
	git clone ${shellscripts_repo_url}

	cd ./${repo_name}

	echo "Running ${repo_name} installer.sh"
	bash ./installer.sh
	echo ""

	# return to original working directory
	cd $cwd
else
	echo "Warning: git not found!"
	echo "Warning: $repo_name will not be installed"

fi

echo "$0 has finished"
