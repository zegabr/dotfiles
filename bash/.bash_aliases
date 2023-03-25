#LINUX
export EDITOR=nvim
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y; sudo snap refresh; source ~/dotfiles/scripts/scripts/stuff/r.sh'
alias update-nvim='source ~/dotfiles/scripts/scripts/stuff/v.sh'
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
complete -F _ga_completion gd
alias ga='git add'
alias gd='git diff'
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

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gp='git push'
alias gl='git pull'
alias glo='git log --oneline --decorate'
complete -F _gco_completion grb
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

##COMPETITIVE/C++
alias m='make && make t'
alias c='g++ -std=c++20 -Ofast -Wshadow -Wall -Wno-unused-result -g -fsanitize=address,undefined -D_GLIBCXX_DEBUG -Wno-unused-result -Wno-sign-compare -Wno-char-subscripts'
alias tc='time g++ -std=c++20 -Ofast'
alias cw='g++ -std=c++20 -Ofast -Wfatal-errors'
alias getcppincludepaths='g++ -E -x c++ - -v < /dev/null'

# cheat.sh
alias how='cht.sh'

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

## FZF
export FZF_DEFAULT_OPTS="--reverse --inline-info"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"

[[ $TMUX != "" ]] && export TERM="screen-256color"

# cdf - cd into the directory of the selected file
_cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

_reverse_search_fzf() {
    selected=$(history | awk '{$1=""; print substr($0,2)}' | fzf)
    echo "$selected"
    eval "$selected"
}

_open_scrollback_in_neovim() {
    tmux capture-pane -pS -10000 > ~/.tmux_scrollback_temp && nvim -c "$" ~/.tmux_scrollback_temp && rm ~/.tmux_scrollback_temp
}

_tmux_sessionizer() {
    CURR_DIR=$(pwd)

    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/ ~/Desktop -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
    fi

    if ! tmux has-session -t $selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi

    if [[ -z $TMUX ]]; then
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    fi

    cd $CURR_DIR
}

_chatgpt() {
    # Set up your OpenAI API key by adding it to the openaikey file
    export OPENAI_API_KEY=$(cat ~/openaikey)

    read -p "ask to gpt3.5-turbo:" prompt
    echo ===============
     curl -s https://api.openai.com/v1/chat/completions -H "Content-Type: application/json" -H "Authorization: Bearer $OPENAI_API_KEY" -d '{
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "'"$prompt"'"}]
      }' | jq -r ".choices[0].message.content"
}

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
    # telegram
   sudo dpkg -r $1
}

bind '"\C-b":"fg\n"'
bind '"\C-h":"_chatgpt\n"'
bind '"\C-f":"_tmux_sessionizer\n"'
bind '"\C-n":"_open_scrollback_in_neovim\n"'
bind '"\C-r":"_reverse_search_fzf\n"'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

if [ -f ~/.bash_aliases_work ]; then
    . ~/.bash_aliases_work
fi
