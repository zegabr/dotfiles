#!/bin/sh
# m for main

# core
bash setup_core.sh #install apps and docker

# extra
bash setup_extra.sh
bash ssh.sh # setup ssh for github
