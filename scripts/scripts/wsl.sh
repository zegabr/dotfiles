#!/bin/sh
# wsl
#

# for windows WSL neovim to work with clipboard
sudo apt update -y
sudo apt install xdg-utils curl unzip -y
sudo curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
sudo unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
sudo chmod +x /tmp/win32yank.exe
sudo sudo mv /tmp/win32yank.exe /usr/local/bin/

# core
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_core.sh)

# install cheat sheet
# 1- enable wsl and hyper-v in windows features
# 2- enable virtualization mode on bios
# 3- install distro via store
#
# uninstall cheat sheet:
# 1- uninstall via start menu
# 2- wsl --list
# 3- wsl --unregister <name>
