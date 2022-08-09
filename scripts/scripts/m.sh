#!/bin/sh
# m for main

bash setup.sh #install apps and docker
source v.sh # install nvim building from source
source f.sh # install FiraCode font
bash t.sh # install tmux
bash ssh.sh # setup ssh
source d.sh # simlinks things

