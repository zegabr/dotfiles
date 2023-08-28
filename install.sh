# define a list of directories to be stowed
directories=(scripts nvim bash terminal)

# iterate over the list of directories
for dir in ${directories[@]}
do
  # un-stow the directory
  stow -D --verbose=2 $dir
  # stow the directory in the home directory
  stow --verbose=2 -t ~ $dir
done

source ~/.bashrc

# for gnome
dconf load / < ~/dotfiles/gnome/gnome-settings

# for kde
python3 -m venv ~/konsave
~/konsave/bin/pip install konsave
~/konsave/bin/konsave -i ~/dotfiles/kde/kde_ze.knsv
~/konsave/bin/konsave -a kde_ze

