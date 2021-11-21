" ============SETS (and passive mappings)============
syntax on
filetype on
filetype plugin on
set modifiable " make netrw be able to modify directories
set grepprg=rg\ --vimgrep " use rg as default grepper
set updatetime=100
set encoding=utf-8
set guicursor=
set exrc "also source vimrcs inside directory of file
set nocompatible
set showcmd
set showmatch " show matching open-closing symbol
set splitright splitbelow
set hidden
set title
set scrolloff=8
set list
set listchars=tab:>\ ,trail:-

set number " show line numbers
set relativenumber "line numbers moving relatively
set noerrorbells
set nowrap
set cursorline cursorcolumn

set nohlsearch "search highlight off
set incsearch "cursor moves as soon as typing search
set ignorecase "search ignore cases
set smartcase "search start to not ignore cases if search for uppercase letter

set signcolumn=yes "leftmost column, used for linting
set colorcolumn=80

set shortmess+=A "ignores swap files error

" sets tab width in spaces
set softtabstop=4
" sets width to be used when using indentation in normal mode
set shiftwidth=4
" width of tab char
set tabstop=4
" if set uses spaces intead of tabs
set expandtab
set autoindent

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" better tabbing
vnoremap < <gv
vnoremap > >gv

" jumpList mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap

" ==========BETTER WHITESPACE================
let g:better_whitespace_enabled=1

let g:netrw_browse_split = 0
let g:netrw_banner = 1
let g:netrw_winsize = 25
