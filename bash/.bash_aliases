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
alias pomo='porsmo'

#-----------------------config files shortcuts
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
# cheat.sh
alias how='cht.sh'

#Open current day note file
function note(){
    cd ~/notes
    filename=$(date +'%a-%m-%d-%Y')
    v ~/notes/${filename}.txt +
}

## FZF
export FZF_DEFAULT_OPTS="--reverse --inline-info"
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"

# tmux color fix
[[ $TMUX != "" ]] && export TERM="screen-256color"

# source ~/.local/_competitive
source ~/.local/_git_utils
source ~/.local/_debian_utils

source ~/.local/_chatgpt
bind '"\C-h":"_chatgpt\n"'
source ~/.local/_tmux_sessionizer
bind '"\C-f":"_tmux_sessionizer\n"'
source ~/.local/_reverse_search_fzf
bind '"\C-r":"_reverse_search_fzf\n"'
source ~/.local/_tmux_open_scrollback_on_nvim
bind '"\C-n":"_tmux_open_scrollback_on_nvim\n"'

bind '"\C-b":"fg\n"'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

if [ -f ~/.bash_aliases_work ]; then
    . ~/.bash_aliases_work
fi
