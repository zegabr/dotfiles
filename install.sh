stow -D --verbose=2 m
stow --verbose=2 -t ~/ m
echo "===="
echo
stow -D --verbose=2 nvim
stow --verbose=2 -t ~/ nvim
echo "===="
echo
stow -D --verbose=2 bash
stow --verbose=2 -t ~/ bash
echo "===="
echo
stow -D --verbose=2 zsh
rm ~/.zshrc
stow --verbose=2 -t ~/ zsh; source ~/.zshrc
