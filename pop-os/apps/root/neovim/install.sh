#!/usr/bin/env bash

# if nvim is not already installed
command -v nvim >/dev/null 2>&1 || {
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	mv nvim.appimage /usr/bin/nvim
}
