#LINUX
export EDITOR=nvim
alias sai='sudo apt install -y'
alias sap='sudo apt purge -y'
alias update-nvim='source ~/dotfiles/scripts/scripts/stuff/v.sh'
alias update-node='source ~/dotfiles/scripts/scripts/stuff/node.sh'
alias update-rust-tools='source ~/dotfiles/scripts/scripts/stuff/r.sh'
alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'

function update-dump(){
    # for gnome
    if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
        dconf dump / > ~/dotfiles/gnome/gnome-settings
    fi
    # for kde
    if [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
        cp ~/.config/dolphinrc ~/dotfiles/kde/.config
        cp ~/.config/kdeglobals ~/dotfiles/kde/.config
        cp ~/.config/kglobalshortcutsrc ~/dotfiles/kde/.config
        cp ~/.config/khotkeysrc ~/dotfiles/kde/.config
        cp ~/.config/ktimezonedrc ~/dotfiles/kde/.config
        cp ~/.config/kwinrc ~/dotfiles/kde/.config
        cp ~/.config/kxkbrc ~/dotfiles/kde/.config
        cp ~/.config/plasma-localerc ~/dotfiles/kde/.config
        cp ~/.config/powerdevilrc ~/dotfiles/kde/.config
        cp ~/.config/powermanagementprofilesrc ~/dotfiles/kde/.config
        cp ~/.config/touchpadxlibinputrc ~/dotfiles/kde/.config
        cp ~/.config/Trolltech.conf ~/dotfiles/kde/.config
        cp ~/.config/xsettingsd.conf ~/dotfiles/kde/.config
        cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/dotfiles/kde/.config
    fi
}

alias lag='alias | grep'

alias v='nvim'
function vs(){
    if [ -e Session.vim ]; then
        nvim -S
    else
        nvim . -c Obsession
    fi
}
alias t='tmux attach -t base || tmux new -s base'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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
# -----------------global python
alias py='python3'
venv-create() {
    cd ~
    python3 -m venv ~/.myvenvs/$1
    cd -
}

venv-activate() {
    source ~/.myvenvs/$1/bin/activate
}
venv-deactivate() {
    deactivate
}

pip(){
    if [ -n "$VIRTUAL_ENV" ]; then
        $VIRTUAL_ENV/bin/pip "$@"
    else
        env pip "$@"
    fi
}
pip3(){
    if [ -n "$VIRTUAL_ENV" ]; then
        $VIRTUAL_ENV/bin/pip3 "$@"
    else
        env pip3 "$@"
    fi
}


# cheat.sh
alias how='cht.sh'

mkdir ~/thoughts > /dev/null
#Open instant note
function think(){
    cd ~/thoughts
    filename=$(date +'%a-%m-%d-%Y')
    v ${filename}.md +
}

mkdir ~/notes > /dev/null
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
    if [ -e Session.vim ]; then
        vs
    else
        v index.md
    fi
}

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
