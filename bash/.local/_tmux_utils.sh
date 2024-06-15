#!/bin/sh

alias t='tmux attach -t base || tmux new -s base'

# tmux color fix
[[ $TMUX != "" ]] && export TERM="screen-256color"

_remove_empty_trailing_lines() {
    sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' $1
    # below for macos
    # sed -i '' -e ':a' -e '/^\n*$/{$d;N;};/\n$/ba' $1
}


_tmux_open_scrollback_on_nvim() {
    tmux capture-pane -pS -10000 > ~/.tmux_scrollback_temp && _remove_empty_trailing_lines ~/.tmux_scrollback_temp && nvim -c "$" ~/.tmux_scrollback_temp && rm ~/.tmux_scrollback_temp
}
bind '"\C-n":"_tmux_open_scrollback_on_nvim\n"'


mkdir ~/work/test > /dev/null
mkdir ~/personal/test > /dev/null
_tmux_sessionizer() {
    CURR_DIR=$(pwd)

    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find \
            ~/ \
            ~/work \
            ~/work/test \
            ~/personal \
            ~/personal/test \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            | fzf)
    fi

    if [[ -z $selected ]]; then
        return 0
    fi

    tmux_running=$(pgrep tmux)
    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected -c $selected -e "PROJECT=$selected"
        exit 0
    fi

    if ! tmux has-session -t $selected 2> /dev/null; then
        tmux new-session -ds $selected -c $selected -e "PROJECT=$selected"
    fi

    if [[ -z $TMUX ]]; then
        tmux attach-session -t $selected
    else
        tmux switch-client -t $selected
    fi

    cd $CURR_DIR
}
bind '"\C-f":"_tmux_sessionizer\n"'

if ! [ -z "$PROJECT" ]; then
  hgd $PROJECT
fi
