#LINUX
export EDITOR=nvim
alias sai='sudo apt install -y'
alias sap='sudo apt purge -y'
alias update-nvim='source ~/dotfiles/scripts/scripts/stuff/v.sh'
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y; source ~/dotfiles/scripts/scripts/stuff/r.sh'

alias lag='alias | grep'

alias v='nvim'
alias vs='nvim -S'
alias t='tmux attach -t base || tmux new -s base'
alias bro='browse'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Rust
alias ll='exa -l'
alias lla='exa -la'
alias cat='bat'
alias pomo='porsmo'

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
# cheat.sh
alias how='cht.sh'

#Open current day note file
function note(){
    cd ~/notes
    filename=$(date +'%a-%m-%d-%Y')
    v ~/notes/${filename}.txt +
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
