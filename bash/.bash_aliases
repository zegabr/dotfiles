#LINUX
export EDITOR=nvim
alias update='sudo apt update && sudo apt -u upgrade -y && sudo apt autoclean -y && sudo apt clean -y && sudo apt autoremove -y && sudo apt --fix-broken install -y; sudo snap refresh; source ~/scripts/r.sh'
alias update-nvim='source ~/scripts/v.sh'
alias lag='alias | grep'
alias v='nvim'
alias vs='nvim -S'
alias t='tmux attach -t base || tmux new -s base'
alias bro='browse'

# Rust
alias l='exa -l'
alias ls='exa'
alias cat='bat'

#-----------------------files
alias ev='dot && v ~/.config/nvim/init.lua'
alias dot='cd ~/dotfiles'

alias eb='v ~/.bashrc'
alias ea='v ~/.bash_aliases'
alias ew='v ~/.bash_aliases_work'
alias et='v ~/.tmux.conf'

alias sb='source ~/.bashrc'
alias sa='source ~/.bash_aliases'
alias sw='source ~/.bash_aliases_work'
alias st='tmux source-file ~/.tmux.conf'
# -----------------global python
alias py='python3'

#Open current day note file
function note(){
    cd ~/notes
    filename=$(date +'%a-%m-%d-%Y')
    v ~/notes/${filename}.txt +
}

function swap-java(){
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
}

#--------------------git utilities
alias gs='git status'
alias guncommit='git reset HEAD~1 --soft'
function _ga_completion() {
    files=$(git status --porcelain | awk '{print $NF}')
    COMPREPLY=($(compgen -W "${files}" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _ga_completion ga
alias ga='git add'
alias gaa='git add .'
alias gb='git branch'
alias gcb='git checkout -b'

function _gco_completion() {
  branches=$(git branch | awk '{print $NF}')
  COMPREPLY=($(compgen -W "${branches}" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _gco_completion gco
complete -F _gco_completion gbd
complete -F _gco_completion gbD
alias gco='git checkout'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gd='git diff'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcan!='git commit -v -a --no-edit -amend'
alias gp='git push'
alias gl='git pull'
alias glo='git log --oneline --decorate'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias gsta='git stash push'
alias gstp='git stash pop'

# clone github repo via ssh
function gclssh(){
    git clone --recurse-submodules git@github.com:$1.git
}

# clone github repo via ssh using ssh config id
# ex: $ gclssh-by-id zegabr zegabr/m
# use this when multiple ssh keys are added
function gclssh-by-id(){
git clone --recurse-submodules git@github.com-$1:$2.git
}

# config local user and email
# ex: $ gconfiglocal <user> <email>
function gconfiglocal(){
    git config user.name $1
    git config user.email $2
}

# clone github repo via https
function gclhttps(){
    git clone --recurse-submodules https://github.com/$1
}

## change keyboard numerical row mappings to its symbols
#function remaper(){
#FLAG=~/REMAPER_ON_FLAG
#if [ ! -f "$FLAG" ]; then
#echo "activating remaper"
##original mapping:		#new mapping
##keycode 10 = 1			 exclam = '!'
##keycode 11 = 2			 at = '@'
##keycode 12 = 3			 numbersign = '#'
##keycode 13 = 4			 dollar = '$'
##keycode 14 = 5		     percent = '%'
##keycode 15 = 6			 asciicircum = '^'
##keycode 16 = 7			 ampersand = '&'
##keycode 17 = 8			 asterisk = '*'
##keycode 18 = 9			 parenleft = '('
##keycode 19 = 0			 parenright = ')'
##keycode 20 = minus		 underscore = '_'

        ##commands to remap
        #xmodmap -e "keycode 10 = exclam"
        #xmodmap -e "keycode 11 = at"
        #xmodmap -e "keycode 12 = numbersign"
        #xmodmap -e "keycode 13 = dollar"
        #xmodmap -e "keycode 14 = percent"
        #xmodmap -e "keycode 15 = underscore"
        #xmodmap -e "keycode 16 = ampersand"
        #xmodmap -e "keycode 17 = asterisk"
        #xmodmap -e "keycode 18 = parenleft"
        #xmodmap -e "keycode 19 = parenright"
        #xmodmap -e "keycode 20 = underscore"
        #echo 1 > "$FLAG"
        #else
        #echo "deactivating remaper"
        #setxkbmap -option
        #rm "$FLAG"
        #fi
        #}

##COMPETITIVE/C++
alias m='make && make t'
alias c='g++ -std=c++17 -O2 -Wshadow -Wall -Wno-unused-result -g -fsanitize=address,undefined -D_GLIBCXX_DEBUG -Wno-unused-result -Wno-sign-compare -Wno-char-subscripts'
alias tc='time g++ -std=c++17 -O2'
alias cw='g++ -std=c++17 -O2 -Wfatal-errors'
alias getcppincludepaths='g++ -E -x c++ - -v < /dev/null'

## FZF
export FZF_DEFAULT_OPTS="--reverse --inline-info"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"

# cdf - cd into the directory of the selected file
cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# cheat.sh
alias how='cht.sh'
# openai
alias openai='bash ~/.local/openai.sh'

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

if [ -f ~/.bash_aliases_work ]; then
    . ~/.bash_aliases_work
fi

# bind ^f tmux-sessionizer
bind '"\C-f":". ~/.local/tmux-sessionizer.sh\n"'
bind '"\C-b":"fg\n"'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

[[ $TMUX != "" ]] && export TERM="screen-256color"

function extract(){
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

function deb-install(){
   # telegram.deb
   sudo dpkg -i $1
}
function deb-uninstall(){
    # # telegram
   sudo dpkg -r $1
}
