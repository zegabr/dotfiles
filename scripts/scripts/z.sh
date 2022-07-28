#!/bin/sh
# Z-Shell installation (with oh-my-zsh)
rm -rf ~/.oh-my-zsh

sudo apt install zsh curl -y
chsh -s $(which zsh) #change default terminal to be zsh

echo """

======================== PRESS CTRL D AFTER TERMINAL CHANGES TO CONTINUE ==================

"""

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#clone plugins as such
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

echo "PLS OPEN ANOTHER TERMINAL FOR CHANGES TAKE EFFECT "
