
# custom scripts (aka modules)
# source ~/.local/_competitive.sh
source ~/.local/_git_utils.sh
source ~/.local/_debian_utils.sh
source ~/.local/_java_utils.sh
source ~/.local/_fzf_utils.sh
source ~/.local/_tmux_utils.sh
source ~/.local/_python_utils.sh
source ~/.local/_note_system.sh

# Rust
alias l='exa -l'
alias la='exa -la'
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

# cheat.sh
alias how='cht.sh'

# llms
alias llm-codellama='ollama run codellama'
alias llm-mistral='ollama run mistral'

bind '"\C-b":"fg\n"'
bind 'TAB:menu-complete'
bind 'set show-all-if-ambiguous on'

if [ -f ~/.bash_aliases_work ]; then
    . ~/.bash_aliases_work
fi
