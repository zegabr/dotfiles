# define a list of directories to be stowed
directories=(scripts nvim bash tmux bin starship)

# iterate over the list of directories
for dir in ${directories[@]}
do
  # un-stow the directory
  stow -D --verbose=2 $dir
  # stow the directory in the home directory
  stow --verbose=2 -t ~ $dir
done

sudo chmod -x ~/.local/tmux-sessionizer.sh
sudo chmod -x ~/.local/openai.sh
