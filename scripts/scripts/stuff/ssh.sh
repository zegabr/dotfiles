#!/bin/sh
sudo apt update -y
sudo apt install xclip ssh-tools -y
read -p "Type y if you want to setup default ssh for git? (y/n): " ans
if [ "$ans" == "y" ]; then

    read -p "Enter Your Github username: " USER_NAME
    read -p "Enter Your Github email: " USER_EMAIL

    echo "setting github ssh with email $USER_EMAIL!"

    ssh-keygen -t rsa -b 4096 -C $USER_EMAIL
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

    echo "
# github account: ${USER_NAME}
Host github.com
HostName github.com
IdentityFile ~/.ssh/id_rsa
IdentitiesOnly yes

" > ~/.ssh/config
    echo
    echo "Please check if everything is ok at ~/.ssh/config"
    nvim ~/.ssh/config

    if [[ $(uname -a | grep microsoft) ]]; then
        clip.exe < ~/.ssh/id_rsa.pub
    else
        xclip -selection clipboard < ~/.ssh/id_rsa.pub
    fi

    echo """
    ===================================================
    The ssh key is in clipboard, add it to github client
    ===================================================
    """

    echo """
    ===================================================
    To clone a private repo, use
    git clone git@github.com:repo-user/repo-name.git
    ===================================================
    """

    sensible-browser https://github.com/settings/keys
    read -n 1 -s -r -p "Press any key to continue"
fi

