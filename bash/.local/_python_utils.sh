#!/bin/sh

# -----------------global python
alias py='python3'

venv-create() {
    cd ~
    python3 -m venv ~/.myvenvs/$1
    cd -
}

venv-activate() {
    selected=$(find \
            ~/.myvenvs/ \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            | fzf)
    source $selected/bin/activate
}

venv-deactivate() {
    deactivate
}

function pip() {
    if [ -n "$VIRTUAL_ENV" ]; then
        $VIRTUAL_ENV/bin/pip "$@"
    else
        env pip "$@"
    fi
}

function pip3() {
    if [ -n "$VIRTUAL_ENV" ]; then
        $VIRTUAL_ENV/bin/pip3 "$@"
    else
        env pip3 "$@"
    fi
}
