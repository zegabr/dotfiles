#!/bin/sh

# jj
alias js='jj log -r 'main..' --no-pager && jj status --no-pager'
alias jf='jj fix'
alias jc='jj commit'
alias jrew='jj describe'
alias jn='jj new' # checkout and start new node, will amend by jj squash later
alias ja='jj squash'
alias je='jj edit' # checkout and edit amending
alias jl='jj git fetch && js'
alias jgp='jl && jj git push'
alias jsplit='jj split'
alias jprune='jj abandon'
alias jresolve='jj resolve'
alias jj-git-init='jj git init --colocate'

# TODO: find a way to also drop the forgotten cls
alias jjforgetbookmark='jj bookmark forget --include-remotes'
# revert/drop cls
alias jdrop='jj piper cls drop'

function jrebase {
    # use as `jrebase a b`
    jj rebase -s $1 -o $2
}

# helpers for opening last changed files
smart-diff() {
  # Run jj diff --name-only for the current commit vs its parent
  local output=$(jj diff --name-only)

  # Check if the output is empty
  if [ -z "$output" ]; then
    # If empty, run the diff for the parent vs the grandparent
    jj diff --name-only --from @--
  else
    # Otherwise, print the output from the first command
    echo "$output"
  fi
}
alias vj='v $(smart-diff)'

