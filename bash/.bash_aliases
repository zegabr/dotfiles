#LINUX
export EDITOR=nvim
alias sai='sudo apt install -y'
alias sap='sudo apt purge -y'
alias update-nvim='source ~/dotfiles/scripts/scripts/stuff/v.sh'
alias update-node='source ~/dotfiles/scripts/scripts/stuff/node.sh'
alias update-rust-tools='source ~/dotfiles/scripts/scripts/stuff/r.sh'
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
alias update-dump-gnome='dconf dump / > ~/dotfiles/gnome/gnome-settings'
function update-dump-kde(){
    cp -r ~/.config/plasma* ~/dotfiles/kde/.config/
    cp -r ~/.config/k* ~/dotfiles/kde/.config/
    rm -rf ~/dotfiles/kde/.config/kdeconnect
    cp -r ~/.config/Trolltech.conf ~/dotfiles/kde/.config/
    cp -r ~/.config/touchpadxlibinputrc ~/dotfiles/kde/.config/
    cp -r ~/.config/powermanagementprofilesrc ~/dotfiles/kde/.config/
    cp -r ~/.config/bluedevilglobalrc ~/dotfiles/kde/.config/
}

alias lag='alias | grep'

alias v='nvim'
function vs(){
    if [ -e Session.vim ]; then
        nvim -S
    else
        nvim .
    fi
}
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
    git commit -m 'sync'
    git pull --rebase
    git push -q
}
# Opens instant note on private repo
function note(){
    cd ~/notes
    note-sync & > /dev/null
    if [ -e Session.vim ]; then
        vs
    else
        v index.md
    fi
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
