" -----------------------------PLUGINS---------------------------------------
"  TO install vim-plug, run the vim plug install script at
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(stdpath('data') . '/plugged')
" FuzzyFinder FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'airblade/vim-rooter'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Nerd Commenter
Plug 'preservim/nerdcommenter'

" nerd tree
Plug 'preservim/nerdtree'

"color scheme and fonts
Plug 'gruvbox-community/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" easymotion
Plug 'easymotion/vim-easymotion'
" vim surround
Plug 'tpope/vim-surround'
" visual star search
Plug 'bronson/vim-visual-star-search'
" Undotree
Plug 'mbbill/undotree'

call plug#end()

" -------------------------------------------------------------------------------
"--------------------------------------SETS--------------------------------------
syntax on
filetype on
filetype plugin on
set updatetime=100
set encoding=utf-8
set guicursor=
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
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

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

"below command is for vimrc testing while ediing it
autocmd! bufwritepost .vimrc source $MYVIMRC
" ----------------------------------------------------------------------------
"-----------------------------COLORS------------------------------------------
set termguicolors

set noshowmode
colorscheme gruvbox
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
set background=dark
" ----------------------------------------------------------------------------
"-----------------------------MAPS--------------------------------------------
nnoremap <Space> <nop>
vnoremap <Space> <nop>
let mapleader = " "

"Navigate splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"ctrl A select all file, y and p uses system clipboard
set clipboard=unnamedplus
noremap <C-a> GVgg
nnoremap Y y$

"esc and save in jk 
inoremap jk <ESC>

"go up, go down, with lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==i
inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

"toggle word case
inoremap <c-u> <esc>lviw~<esc>
nnoremap <c-u> viw~<esc>

nnoremap <Right> <nop>
nnoremap <Left> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

" jumpList mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"center things
nnoremap G Gzz
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz
nnoremap n nzzzv
nnoremap N nzzzv
nnoremap J mzJ'z

"replace all ocurrence by typing old and new
nnoremap S :%s//gI<Left><Left><Left>

"replace ocurrences of last searched word
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" same as above, but works in a visual selection
xnoremap <leader>r :s///g<left><left>
xnoremap <leader>rc :s///gc<left><left><left>

" alternate between opened buffers
nnoremap <S-TAB> :bp<CR>
nnoremap <TAB> :bn<CR>
" close only current buffer
nnoremap <C-w> :w<CR>:bd<CR>

" better tabbing
vnoremap < <gv
vnoremap > >gv

" resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" ----------------------------------------------------------------------------
"-----------------------------UNDOTREE----------------------------------------
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.undodir
set undofile
nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" undo break points
inoremap , ,<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u
" ----------------------------------------------------------------------------
"-----------------------------NERDCOMMENTER-----------------------------------
filetype plugin on
imap <C-_> <ESC><Plug>NERDCommenterToggle
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
" ----------------------------------------------------------------------------
"-----------------------------GIT---------------------------------------------
" git status
nnoremap <leader>gs :G<CR>
" git checkout
nnoremap <leader>gb :GBranches<CR>
" diffget left theirs ans yours
nmap <leader>gf :diffget //2<CR>
nmap <leader>gh :diffget //3<CR>
" ----------------------------------------------------------------------------
"-----------------------------FZF---------------------------------------------
" automatically chooses between project files and git files
function! s:find_files()
    let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if git_dir != ''
        execute 'GFiles' git_dir
    else
        execute 'Files'
    endif
endfunction
command! ProjectFiles execute s:find_files()

nnoremap <C-p> :ProjectFiles<CR>
noremap <C-b> :Buffers<CR>
noremap <C-f> :Rg!<CR> 
"-----------------------------------------------------------------------------
" ----------------------------EASYMOTION-------------------------------------------
nmap f <Plug>(easymotion-bd-f)
nmap F <Plug>(easymotion-bd-f2)
"----------------------------------------------------------------------------------
"------------------------------NERDTREE-----------------------------------------
nnoremap <leader>e :NERDTreeToggle<CR>
