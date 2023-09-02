#LINUX
export EDITOR=nvim
alias sai='sudo apt install -y'
alias sap='sudo apt purge -y'
alias update-nvim='source ~/dotfiles/scripts/scripts/stuff/v.sh'
alias update-node='source ~/dotfiles/scripts/scripts/stuff/node.sh'
alias update-rust-tools='source ~/dotfiles/scripts/scripts/stuff/r.sh'
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
alias update-dump='dconf dump / > ~/dotfiles/gnome/gnome-settings'

alias lag='alias | grep'

alias v='nvim'
alias vs='nvim -S'
alias t='tmux attach -t base || tmux new -s base'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Rust
alias l='exa'
alias ll='exa -l'
alias lla='exa -la'
alias cat='bat'

#-----------------------config files shortcuts
alias dot='cd ~/dotfiles'
alias ev='dot && v ~/.config/nvim/init.lua'

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
venv-create() {
    cd ~
    python3 -m venv $1
    cd -
}
venv-activate() {
    source ~/$1/bin/activate
}

# cheat.sh
alias how='cht.sh'

#Open instant note
function think(){
    cd ~/toughts
    filename=$(date +'%a-%m-%d-%Y')
    v ${filename}.md +
}

#Opens personal notes dir and sync
function note-sync(){
    cd ~/notes
    git add .
    git commit -m 'sync' > /dev/null
    git pull --rebase > /dev/null
    git push -q > /dev/null
}
# Opens instant note on private repo
function note(){
    cd ~/notes
    note-sync &
    filename=$(date +'%a-%m-%d-%Y')
    v ${filename}.md +
}

# tmux color fix
[[ $TMUX != "" ]] && export TERM="screen-256color"

# custom scripts
source ~/.local/_competitive
source ~/.local/_git_utils
source ~/.local/_debian_utils
source ~/.local/_fzf_utils
source ~/.local/_tmux_utils

bind '"\C-f":"_tmux_sessionizer\n"'
bind '"\C-n":"_tmux_open_scrollback_on_nvim\n"'

bind '"\C-b":"fg\n"'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

if [ -f ~/.bash_aliases_work ]; then
    . ~/.bash_aliases_work
fi
