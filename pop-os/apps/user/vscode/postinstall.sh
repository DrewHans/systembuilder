#!/usr/bin/env bash


# check vscode is installed (should have installed via apt)
command -v code >/dev/null 2>&1 && {
	echo "Installing Visual Studio Code extensions"

	code --install-extension ms-azuretools.vscode-docker
	code --install-extension ms-dotnettools.csharp
	code --install-extension ms-python.python
	code --install-extension ms-python.vscode-pylance
	code --install-extension ms-vscode.cpptools
	code --install-extension platformio.platformio-ide

	echo "Visual Studio Code extensions have been installed"
	echo ""
}

# output message if not installed
command -v code >/dev/null 2>&1 || {
	echo "Visual Studio Code is not installed"
	echo "Skipping vscode extensions installation"
	echo ""
}
