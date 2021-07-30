syntax on
filetype on
filetype plugin on
set updatetime=100
set exrc "also source vimrcs inside directory of file
set nocompatible
set showcmd
set ruler 
set splitright splitbelow
set hidden
set title 
set scrolloff=8
set wildmode=longest,list,full
set wildmenu
set relativenumber "line numbers moving relatively
set number
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


set statusline=File:\ %F\  
set statusline+=--Line:\ %l/%L

" sets tab width in spaces
set softtabstop=4
" sets width to be used when using indentation in normal mode 
set shiftwidth=4
" width of tab char
set tabstop=4
" if set uses spaces intead of tabs
set expandtab
set autoindent


function! CPPSET()
    set cindent
    set textwidth=0
    set nowrap
    set ts=4 
    set sw=4 
    set sts=4 
    set expandtab 

    "abbreviations here
    " does not work with coc pairs
    ":iabbrev sp ' '
    ":iabbrev pl '\n'
    :iabbrev ee &
    :iabbrev adn and
    :iabbrev endk endl
    :iabbrev enld endl
endfunction

function! PYSET()
    set tw=0
    set nowrap
    setlocal expandtab
    setlocal smarttab
    set ts=4 
    set sw=4 
    set sts=4 
    set noexpandtab
endfunction

"below command is for vimrc testing while ediing it
autocmd! bufwritepost .vimrc source $MYVIMRC
autocmd! bufwritepre,bufread *.cpp :normal mijkgg=G'izz
autocmd! FileType python call PYSET() 
autocmd! Filetype cpp call CPPSET()
autocmd! Filetype c call CPPSET()
