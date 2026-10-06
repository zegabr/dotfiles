# define a list of directories to be stowed
directories=(scripts nvim bash terminal)

# stow macOS-specific additions only when running on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  directories+=(macos)
fi

# iterate over the list of directories
for dir in ${directories[@]}
do
  # un-stow the directory
  stow -D --verbose=2 $dir
  # stow the directory in the home directory
  stow --verbose=2 -t ~ $dir
done

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
