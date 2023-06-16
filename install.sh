# define a list of directories to be stowed
directories=(scripts nvim bash terminal kubuntu)

# remove kde config files to be symlinked
rm ~/.config/khotkeysrc ~/.config/kglobalshortcutsrc

# iterate over the list of directories
for dir in ${directories[@]}
do
  # un-stow the directory
  stow -D --verbose=2 $dir
  # stow the directory in the home directory
  stow --verbose=2 -t ~ $dir
done

source ~/.bashrc

