#!/bin/sh

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
