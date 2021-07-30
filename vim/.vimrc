" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
" FuzzyFinder FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'airblade/vim-rooter'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Undotree
Plug 'mbbill/undotree'

" Nerd Commenter
Plug 'preservim/nerdcommenter'

" Conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"color scheme and fonts
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" loads other configs
source ~/.vim/plugins/sets.vim
source ~/.vim/plugins/colors.vim
source ~/.vim/plugins/maps.vim
source ~/.vim/plugins/undotree.vim
source ~/.vim/plugins/nerdtree.vim
source ~/.vim/plugins/fzf.vim
source ~/.vim/plugins/git.vim
source ~/.vim/plugins/coc.vim 
