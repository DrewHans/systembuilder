#!/usr/bin/env bash


# check vscodium is installed (should have installed via apt)
command -v codium >/dev/null 2>&1 && {
	echo "Installing VSCodium extensions"

	codium --install-extension ms-python.python
	codium --install-extension ms-azuretools.vscode-docker
	codium --install-extension esbenp.prettier-vscode

	echo "VSCodium extensions have been installed"
	echo ""
}

# output message if not installed
command -v codium >/dev/null 2>&1 || {
	echo "VSCodium is not installed"
	echo "Skipping vscodium extensions installation"
	echo ""
}
