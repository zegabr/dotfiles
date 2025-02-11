#!/bin/sh

export EDITOR=nvim

alias lag='alias | grep'

alias v='nvim'

function vs(){
    if [ -d ".git" ]; then
        if ! grep -q "*.session.vim" ".git/info/exclude"; then
            echo "*.session.vim" >> ".git/info/exclude"
        fi
    else
        if [ ! -f ".session.vim" ]; then  # Check if .session.vim file exists
            echo "No .git folder found in the current directory, .session.vim will be created here"
        fi
    fi
    if [ -e .session.vim ]; then
        nvim -S .session.vim
    else
        nvim . -c "Obsession .session.vim"
    fi
}

alias sai='sudo apt install -y'
alias sap='sudo apt purge -y'
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'

alias via-ui='~/Downloads/via*.AppImage'
alias vial-ui='~/Downloads/Vial*.AppImage'
alias qmk='/home/ze/.local/bin/qmk'
alias update-nvim='source ~/dotfiles/scripts/scripts/stuff/v.sh'
alias update-node='source ~/dotfiles/scripts/scripts/stuff/node.sh'
alias update-rust-tools='source ~/dotfiles/scripts/scripts/stuff/r.sh'
alias update-golang='source ~/dotfiles/scripts/scripts/stuff/g.sh'

alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

extract(){
    # Bash Function To Extract File Archives Of Various Types
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1     ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1     ;;
             *.rar)       rar x $1       ;;
             *.gz)        gunzip $1      ;;
             *.tar)       tar xf $1      ;;
             *.tbz2)      tar xjf $1     ;;
             *.tgz)       tar xzf $1     ;;
             *.zip)       unzip $1       ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

deb-install(){
   # telegram.deb
   sudo dpkg -i $1
}

deb-uninstall(){
    # telegram
   sudo dpkg -r $1
}

check-truecolor() {
awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
s="/\\";
for (colnum = 0; colnum<term_cols; colnum++) {
    r = 255-(colnum*255/term_cols);
    g = (colnum*510/term_cols);
    b = (colnum*255/term_cols);
    if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
}'
}

