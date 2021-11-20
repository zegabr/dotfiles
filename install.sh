stow -D --verbose=2 scripts
stow --verbose=2 -t ~/ scripts
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
echo "===="
echo
stow -D --verbose=2 tmux
stow --verbose=2 -t ~/ tmux
