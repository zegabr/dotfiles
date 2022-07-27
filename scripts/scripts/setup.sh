#!/bin/sh
# FULL LINUX SETUP
bash stuff/apps.sh # for app instalation

sudo apt update && sudo apt upgrade -y && sudo apt --fix-broken install -y

#for working note taking
mkdir ~/notes
