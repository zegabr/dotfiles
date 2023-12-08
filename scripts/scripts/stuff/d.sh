#!/bin/sh
#
(
cd ~

if grep -q 'zegabr' "~/.ssh/config"; then
    git clone git@github.com:zegabr/dotfiles.git
else
    git clone https://github.com/zegabr/dotfiles.git
fi

cd ~/dotfiles/
source install.sh
)
