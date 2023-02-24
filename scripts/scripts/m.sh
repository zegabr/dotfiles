#!/bin/sh
# m for main

bash setup.sh #install apps and docker

source n.sh

source v.sh # install nvim building from source
bash t.sh # install tmux
bash ssh.sh # setup ssh
source d.sh # simlinks things
source ~/.bash_aliases
