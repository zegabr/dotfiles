#!/bin/sh

mkdir ~/thoughts > /dev/null
mkdir ~/notes > /dev/null

#Open instant note
function think(){
    cd ~/thoughts
    filename=$(date +'%a-%m-%d-%Y')
    v ${filename}.md +
}

# Opens instant note on private repo, go back after finishes
function note(){
    (
        cd ~/notes
        if [ -e Session.vim ]; then
            vs
        else
            v index.md
        fi
    )
}

#Opens personal notes dir and sync, comes back after finishes
function note-sync(){
    (
        cd ~/notes
        git add .
        git commit -m 'sync'
        git pull --rebase
        git push -q
    )
}

alias todo='nvim ~/notes/work_todo.md'
