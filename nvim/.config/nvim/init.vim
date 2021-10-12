" -----------------------------PLUGINS---------------------------------------
" To install vim-plug, run the vim plug install script at m/v.sh

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FuzzyFinder FZF
Plug 'junegunn/fzf.vim' " fuzzy search integration
Plug 'stsewd/fzf-checkout.vim' " 
Plug 'airblade/vim-rooter' " rooter
Plug 'airblade/vim-gitgutter' " git diff signs
Plug 'tpope/vim-fugitive' " git support
Plug 'preservim/nerdcommenter' " Nerd Commenter
Plug 'preservim/nerdtree' " nerd tree
Plug 'gruvbox-community/gruvbox' " color scheme and visual customization
Plug 'vim-airline/vim-airline' " airline: bottom status bar and tabs
Plug 'vim-airline/vim-airline-themes' " airline themes
Plug 'justinmk/vim-sneak' " alternative to easymotion (s{char}{char}) and ; or ,
Plug 'tpope/vim-surround' " vim surround
Plug 'bronson/vim-visual-star-search' " visual star search
Plug 'mbbill/undotree' " Undotree
Plug 'matze/vim-move' " alt j/k moves selected lines normal and visual mode
call plug#end()

" ============SETS (and passive mappings)============
syntax on
filetype on
filetype plugin on
set grepprg=rg\ --vimgrep " use rg as default grepper
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
set wildignorecase

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

"below command is for vimrc testing while ediing it
autocmd! bufwritepost *.vim source $MYVIMRC
" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap 

" ============COLORS============
set termguicolors
set noshowmode
colorscheme gruvbox
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
set background=dark

" ============MAPPINGS (active mappings)============
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

"esc with jk 
inoremap jk <ESC>

"replace all ocurrence by typing old and new
nnoremap S :%s//gI<Left><Left><Left>

"replace ocurrences of last searched word
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" same as above, but works in a visual selection
xnoremap <leader>r :s///g<left><left>
xnoremap <leader>rc :s///gc<left><left><left>

" alternate between opened buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
" close only current buffer
nnoremap <C-down> :w<CR>:bd<CR>
" alternate between current edited file and last edited file
nnoremap <up> <C-^>

" tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" ============UNDOTREE============
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

" ============NERDCOMMENTER============
filetype plugin on
imap <C-_> <ESC><Plug>NERDCommenterToggle
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" ============GIT============
" git status
nnoremap <leader>gs :G<CR>
" git checkout
nnoremap <leader>gb :GBranches<CR>
" diffget left theirs ans yours
nmap <leader>gf :diffget //2<CR>
nmap <leader>gh :diffget //3<CR>

" ============FZF============
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"
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

" ============NERDTREE============
nnoremap <leader>e :NERDTreeToggle<CR>
