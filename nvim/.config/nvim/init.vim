" -----------------------------PLUGINS-------------------------------------------
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

"color scheme and fonts
Plug 'gruvbox-community/gruvbox'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" visual star search
Plug 'bronson/vim-visual-star-search'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'kabouzeid/nvim-lspinstall'
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
    :iabbrev sp ' '
    :iabbrev pl '\n'
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
nnoremap <f7> :bp<CR>
nnoremap <f8> :bn<CR>
" close only current buffer
nnoremap <C-f8> :w<CR>:bd<CR>

" terminal TODO: add zsh terminal
nnoremap <C-t> :term<CR>
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
" ----------------------------------------------------------------------------
" ----------------------------LSP----------------------------------------------
"  TODO: something is missing, this does not work EVER
  "navigation
"nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
"nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
 "autoformat
"autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

"set completeopt=menuone,noselect
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"lua << EOF

"require'compe'.setup {
  "enabled = true;
  "autocomplete = true;
  "debug = false;
  "min_length = 1;
  "preselect = 'enable';
  "throttle_time = 80;
  "source_timeout = 200;
  "incomplete_delay = 400;
  "max_abbr_width = 100;
  "max_kind_width = 100;
  "max_menu_width = 100;
  "documentation = false;

  "source = {
    "path = true;
    "buffer = true;
    "calc = true;
    "vsnip = true;
    "nvim_lsp = true;
    "nvim_lua = true;
    "spell = true;
    "tags = true;
    "snippets_nvim = true;
    "treesitter = true;
  "};
"}

"local t = function(str)
  "return vim.api.nvim_replace_termcodes(str, true, true, true)
"end

"local check_back_space = function()
    "local col = vim.fn.col('.') - 1
    "if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        "return true
    "else
        "return false
    "end
"end

"-- Use (s-)tab to:
"--- move to prev/next item in completion menuone
"--- jump to prev/next snippet's placeholder
"_G.tab_complete = function()
  "if vim.fn.pumvisible() == 1 then
    "return t "<C-n>"
  "elseif vim.fn.call("vsnip#available", {1}) == 1 then
    "return t "<Plug>(vsnip-expand-or-jump)"
  "elseif check_back_space() then
    "return t "<Tab>"
  "else
    "return vim.fn['compe#complete']()
  "end
"end
"_G.s_tab_complete = function()
  "if vim.fn.pumvisible() == 1 then
    "return t "<C-p>"
  "elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    "return t "<Plug>(vsnip-jump-prev)"
  "else
    "-- If <S-Tab> is not working in your terminal, change it to <C-h>
    "return t "<S-Tab>"
  "end
"end

"vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
"vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
"vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
"vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
"EOF
