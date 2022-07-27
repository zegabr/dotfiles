#!/bin/sh
# m for main

source z.sh # add updates zshrc, has to be called before dotfiles
rm ~/.zshrc
bash setup.sh #install apps and docker
source v.sh # install nvim building from source
source f.sh # install FiraCode font
bash t.sh # install tmux
bash ssh.sh # setup ssh
source d.sh # remove zshrc and create a symlink to dotfile zshrc

