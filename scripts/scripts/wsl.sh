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

# setup ssh for github
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/ssh.sh)

# core
bash <(curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_core.sh)

# cheat sheet:
# wsl --list
# wsl --unregister <name>
