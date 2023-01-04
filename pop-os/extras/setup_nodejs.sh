#!/usr/bin/env bash


curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

sudo apt install nodejs --yes

# source: https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/development_environment#ubuntu_20.04

command -v node >/dev/null 2>&1 && {
	echo "node has been installed"
	echo "node version:"
	node -v
	echo ""
}

command -v npm >/dev/null 2>&1 && {
	echo "node package manager has been installed"
	echo "npm version:"
	npm -v
	echo ""
}
