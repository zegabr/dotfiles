#!/bin/sh
# wsl
#
# setup ssh for github
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/stuff/ssh.sh | bash

# core
curl -sSL https://raw.githubusercontent.com/zegabr/dotfiles/main/scripts/scripts/setup_core.sh | bash

# for windows WSL neovim to work with clipboard
if [[ $(uname -a | grep microsoft) ]]; then
    sudo apt install xdg-utils -y
    sudo curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    sudo unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    sudo chmod +x /tmp/win32yank.exe
    sudo sudo mv /tmp/win32yank.exe /usr/local/bin/
fi
