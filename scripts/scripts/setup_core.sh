#!/bin/sh

mkdir ~/Downloads
cd ~/Downloads

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install

sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash

cd ~/dotfiles
