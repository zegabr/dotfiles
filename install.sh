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
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    dconf load / < ~/dotfiles/gnome/gnome-settings
    echo "gnome profile set, probably need to logout and login again"
fi

# for kde
if [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    cp -r ~/dotfiles/kde/.config/* ~/.config/
    echo "kde profile set, probably need to logout and login again"
fi
