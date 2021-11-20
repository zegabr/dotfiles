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
Plug 'mbbill/undotree' " Undotree
Plug 'ntpeters/vim-better-whitespace' " trim whitespace with :StripWhiteSpace
Plug 'bronson/vim-visual-star-search' " visual star search
Plug 'matze/vim-move' " alt j/k moves selected lines normal and visual mode
Plug 'romgrk/fzy-lua-native' " dependency for wilder
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' } " wilder menu
Plug 'tpope/vim-surround' " ./plugin/surround.vim
Plug 'svermeulen/vim-yoink' " yank history
" LSP
Plug 'neovim/nvim-lspconfig' " lsp configuration
Plug 'hrsh7th/cmp-buffer' " buffer suggestions
Plug 'hrsh7th/cmp-path' " path suggestions
Plug 'hrsh7th/cmp-nvim-lua' " lua suggestions
Plug 'hrsh7th/cmp-nvim-lsp' " dependency for nvim-cmp
Plug 'hrsh7th/nvim-cmp' " autocompletion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'L3MON4D3/LuaSnip' " TODO: make this work
Plug 'saadparwaiz1/cmp_luasnip' " luasnip src
Plug 'RRethy/vim-illuminate' " vim iluminate

" LSP for java
" npm i -g yarn
" sudo mkdir /usr/local/share/lombok
" sudo wget https://projectlombok.org/downloads/lombok.jar -O /usr/local/share/lombok/lombok.jar
" :CocInstall coc-java coc-snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'} " conquer of completion (ls client used for java)

call plug#end()

lua require("zegabr.lsp")
lua require("zegabr.treesitter")

nnoremap <Space> <nop>
vnoremap <Space> <nop>
let mapleader = " "

" ==========BETTER WHITESPACE================
let g:better_whitespace_enabled=1

" below command is for vimrc testing while editing it
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
autocmd! bufwritepost ~/.config/nvim/*.vim source $MYVIMRC
autocmd! bufwritepost ~/.config/nvim/*.lua source $MYVIMRC
autocmd CursorHold * update
