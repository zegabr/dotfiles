" -----------------------------plugins-------------------------------------------
" install vim-Plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -flo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" run PlugInstall if there are missing plugins
autocmd vimenter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $myvimrc
\| endif

call plug#begin('~/.vim/plugged')
    " fuzzyfinder fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':updateremoteplugins' }
    Plug 'stsewd/fzf-checkout.vim'
    Plug 'airblade/vim-rooter'

    " git
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " undotree
    Plug 'mbbill/undotree'
    
    " nerd commenter
    Plug 'preservim/nerdcommenter'

    " conquer of completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "color scheme and fonts
    Plug 'gruvbox-community/gruvbox'
    Plug 'itchyny/lightline.vim'

    " visual star search
    Plug 'bronson/vim-visual-star-search'
call plug#end()

" -------------------------------------------------------------------------------
"--------------------------------------sets--------------------------------------
syntax on
filetype on
filetype plugin on
set updatetime=100
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
" ignore files
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

set shortmess+=a "ignores swap files error
set mouse=a

set statusline=file:\ %f\  
set statusline+=--line:\ %l/%l

" sets tab width in spaces
set softtabstop=4
" sets width to be used when using indentation in normal mode 
set shiftwidth=4
" width of tab char
set tabstop=4
" if set uses spaces intead of tabs
set expandtab
set autoindent

function! Cppset()
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

function! Pyset()
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
autocmd! bufwritepost .vimrc source $myvimrc
autocmd! bufwritepre,bufread *.cpp :normal mijkgg=g'izz
autocmd! filetype python call Pyset() 
autocmd! filetype cpp call Cppset()
autocmd! filetype c call Cppset()
" ----------------------------------------------------------------------------
"-----------------------------colors------------------------------------------
set termguicolors
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ }
set laststatus=2
if !has('gui_running')
  set t_co=256
endif
set noshowmode
colorscheme gruvbox
set background=dark
" ----------------------------------------------------------------------------
"-----------------------------maps--------------------------------------------
nnoremap <space> <nop>
vnoremap <space> <nop>
let mapleader = " "

"navigate splits
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

"ctrl a select all file, y and p uses system clipboard
set clipboard=unnamedplus
noremap <c-a> gvgg
nnoremap y y$

"esc and save in jk 
inoremap jk <esc>

"go up, go down, with lines
vnoremap j :m '>+1<cr>gv=gv
vnoremap k :m '<-2<cr>gv=gv
inoremap <c-j> <esc>:m .+1<cr>==i
inoremap <c-k> <esc>:m .-2<cr>==i
nnoremap <leader>j :m .+1<cr>==
nnoremap <leader>k :m .-2<cr>==

nnoremap <right> <nop>
nnoremap <left> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

" jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

"center things
nnoremap g gzz
nnoremap n nzz
nnoremap n nzz
nnoremap } }zz
nnoremap { {zz
nnoremap n nzzzv
nnoremap n nzzzv
nnoremap j mzj'z

"replace all ocurrence by typing old and new
nnoremap S :%s//gi<left><left><left>

"replace ocurrences of last searched word
nnoremap <leader>r :%s///g<left><left>
nnoremap <leader>rc :%s///gc<left><left><left>
" same as above, but works in a visual selection
xnoremap <leader>r :s///g<left><left>
xnoremap <leader>rc :s///gc<left><left><left>

" alternate between opened buffers
nnoremap <f7> :bp<cr>
nnoremap <f8> :bn<cr>
" close only current buffer
nnoremap <c-f8> :w<cr>:bd<cr>

" terminal
nnoremap <c-t> :term<cr>
" ----------------------------------------------------------------------------
"-----------------------------undotree----------------------------------------
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.undodir
set undofile
nnoremap <f5> :UndoTreeToggle<cr>
let g:undotree_windowlayout = 2
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
"-----------------------------nerdcommenter-----------------------------------
filetype plugin on
imap <c-_> <esc><plug>NerdNommenterToggle
nmap <c-_> <plug>NerdNommenterToggle
vmap <c-_> <plug>NerdNommenterToggle<cr>gv
" ----------------------------------------------------------------------------
"-----------------------------git---------------------------------------------
" git status
nnoremap <leader>gs :G<cr>
" git checkout
nnoremap <leader>gb :GBranches<cr>
" diffget left theirs ans yours
nmap <leader>gf :diffget //2<cr>
nmap <leader>gh :diffget //3<cr>
" ----------------------------------------------------------------------------
"-----------------------------fzf---------------------------------------------
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

nnoremap <c-p> :ProjectFiles<cr>
noremap <c-b> :Buffers<cr>
noremap <c-f> :Rg!<cr> 
" ----------------------------------------------------------------------------
"-----------------------------coc---------------------------------------------
let g:coc_global_extensions = [
            \'coc-json',
            \'coc-explorer',
            \'coc-sh',
            \'coc-yaml',
            \'coc-spell-checker'
\]

"" this must fix possible issues with pyright not finding project root
autocmd filetype python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

"" better display for messages
set cmdheight=2

"" don't give |ins-completion-menu| messages.
set shortmess+=c

"" use tab for trigger completion with characters ahead and navigate.
"" use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<c-n>" :
      \ <sid>check_back_space() ? "\<tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"" use <cr> to confirm completion, `<c-g>u` means break undo chain at current position.
"" coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

"" use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <plug>(coc-diagnostic-prev)
nmap <silent> ]d <plug>(coc-diagnostic-next)

"" remap keys for gotos
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

"" use k to show documentation in preview window
nnoremap <silent> k :call <sid>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('dohover')
  endif
endfunction

"" highlight symbol under cursor on cursorhold
autocmd cursorhold * silent call CocActionAsync('highlight')

"" remap for rename current word
nmap <f2> <plug>(coc-rename)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s).
  autocmd filetype typescript,json setl formatexpr=CocAction('formatselected')
  " update signature help on jump placeholder
  autocmd user CocJumpPlaceholder call CocActionAsync('showsignaturehelp')
augroup end

"" show all diagnostics.
nnoremap <silent><nowait> <space>d  :<c-u>CocList diagnostics<cr>

"" use `:format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

"" use `:or` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runcommand', 'editor.action.organizeimport')

"" add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""--------------------- coc-explorer--------------------
nnoremap <space>e :CocCommand explorer<cr>
autocmd bufenter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

