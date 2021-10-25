" -----------------------------PLUGINS---------------------------------------
" To install vim-plug, run the vim plug install script at m/v.sh

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin(stdpath('data') . '/plugged')
" FZF integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FuzzyFinder FZF
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' " rooter

" Git integration
Plug 'tpope/vim-fugitive' " git support
Plug 'airblade/vim-gitgutter' " git diff signs on file
Plug 'junegunn/gv.vim' " commit browser
Plug 'stsewd/fzf-checkout.vim' " Git branch management

" Comments
Plug 'preservim/nerdcommenter' " Nerd Commenter

" Colors and UI
Plug 'gruvbox-community/gruvbox' " color scheme and visual customization
Plug 'vim-airline/vim-airline' " airline: bottom status bar and tabs
Plug 'vim-airline/vim-airline-themes' " airline themes

" Utilities
Plug 'tpope/vim-surround' " vim surround
Plug 'bronson/vim-visual-star-search' " visual star search
Plug 'mbbill/undotree' " Undotree
Plug 'matze/vim-move' " alt j/k moves selected lines normal and visual mode
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' } " wilder menu
Plug 'romgrk/fzy-lua-native' " dependency for wilder
Plug 'ntpeters/vim-better-whitespace' " trim whitespace with :StripWhiteSpace

" LSP
Plug 'neovim/nvim-lspconfig' " lsp configuration
Plug 'hrsh7th/cmp-buffer' " buffer suggestions
Plug 'hrsh7th/cmp-path' " path suggestions
Plug 'hrsh7th/cmp-nvim-lua' " lua suggestions
Plug 'hrsh7th/cmp-nvim-lsp' " dependency for nvim-cmp
Plug 'hrsh7th/nvim-cmp' " autocompletion
Plug 'simrat39/symbols-outline.nvim' " highlight symbols on hover
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'L3MON4D3/LuaSnip' " TODO: learn this
call plug#end()

lua require("zegabr.lsp")
lua require("zegabr.treesitter")

so ~/.config/nvim/vim/fzf.vim
so ~/.config/nvim/vim/lsp.vim
so ~/.config/nvim/vim/sets.vim
so ~/.config/nvim/vim/maps.vim
so ~/.config/nvim/vim/colors.vim
so ~/.config/nvim/vim/wilder.vim
so ~/.config/nvim/vim/undotree.vim
so ~/.config/nvim/vim/nerdcommenter.vim
so ~/.config/nvim/vim/git.vim

" ==========BETTER WHITESPACE================
let g:better_whitespace_enabled=1

" below command is for vimrc testing while editing it
autocmd! bufwritepost ~/.config/nvim/* source $MYVIMRC
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

nnoremap <leader>e :Ex<CR>

let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'
