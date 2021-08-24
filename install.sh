stow -D --verbose=2 nvim
stow --verbose=2 -t ~/ nvim
echo
stow -D --verbose=2 bash
stow --verbose=2 -t ~/ bash
echo
stow -D --verbose=2 zsh
rm ~/.zshrc
stow --verbose=2 -t ~/ zsh; source ~/.zshrc
