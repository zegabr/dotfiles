#!/bin/sh

alias gs='git status'
alias guncommit='git reset HEAD~1 --soft'
function _ga_completion() {
    files=$(git status --porcelain | awk '{print $NF}')
    COMPREPLY=($(compgen -W "${files}" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _ga_completion ga
complete -F _ga_completion gd
complete -F _ga_completion gunstage
alias ga='git add'
alias gd='git diff'
alias gaa='git add --all'
alias gunstage='git restore --staged'
alias gb='git branch'
alias gcb='git checkout -b'

function _gco_completion() {
  branches=$(git branch | awk '{print $NF}')
  COMPREPLY=($(compgen -W "${branches}" -- "${COMP_WORDS[COMP_CWORD]}"))
}
complete -F _gco_completion gco
complete -F _gco_completion gbd
complete -F _gco_completion gbD
alias gco='git checkout'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gc='git commit -v -s'
alias gca='git commit -v -s -a'
alias gc!='git commit -v -s --amend'
alias gcan!='git commit -v -a -s --no-edit --amend'
alias gp='git push'
alias gl='git pull'
alias glo='git log --oneline --decorate'
complete -F _gco_completion grb
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias gsta='git stash push'
alias gstp='git stash pop'

# clone github repo via ssh
function gclssh(){
    git clone --recurse-submodules git@github.com:$1.git
}

# clone github repo via https
function gclhttps(){
    git clone --recurse-submodules https://github.com/$1
}

# clone github repo via ssh using ssh config id
# ex: $ gclssh-by-id zegabr zegabr/m
# use this when multiple ssh keys are added
function gclssh-by-id(){
git clone --recurse-submodules git@github.com-$1:$2.git
}

# config local user and email
# ex: $ gconfiglocal <user> <email>
function gconfiglocal(){
    git config user.name $1
    git config user.email $2
}
