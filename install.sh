stow -D --verbose=2 vim # remove simlink
stow --verbose=2 -t ~/ vim # add simlink
echo
stow -D --verbose=2 bash
stow --verbose=2 -t ~/ bash
echo
stow -D --verbose=2 zsh
stow --verbose=2 -t ~/ zsh; source ~/.zshrc
echo
