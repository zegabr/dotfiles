#!/bin/sh
read -p "Type y if you want to add another ssh for git? (y/n): " ans
if [ "$ans" == "y" ]; then

    read -p "Enter Your Github username (will be used to name the ssh key files): " USER_NAME
    read -p "Enter Your Github email: " USER_EMAIL

    echo "setting github ssh with email $USER_EMAIL! at file ~/.ssh/id_rsa_${USER_NAME}"
    echo

    printf ~/.ssh/id_rsa_${USER_NAME} | (ssh-keygen -t rsa -b 4096 -C $USER_EMAIL)
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa_${USER_NAME}

    echo "
# github account: ${USER_NAME}
Host github.com-${USER_NAME}
HostName github.com
IdentityFile ~/.ssh/id_rsa_${USER_NAME}
IdentitiesOnly yes

" >> ~/.ssh/config
echo
echo "Please check if everything is ok at ~/.ssh/config"
gedit ~/.ssh/config &

    xclip -selection clipboard < ~/.ssh/id_rsa_${USER_NAME}.pub

    echo """
    ===================================================
    The ssh key is in clipboard, add it to github client
    ===================================================
    """

    sensible-browser https://github.com/settings/keys

    echo """
    ===================================================
    To clone a private repo, use
    git clone git@github.com-$USER_NAME:repo-user/repo-name.git
    ===================================================
    """
fi
