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
" easymotion
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
" vim surround
Plug 'tpope/vim-surround'
" visual star search
Plug 'bronson/vim-visual-star-search'
" Undotree
Plug 'mbbill/undotree'

call plug#end()

" -------------------------------------------------------------------------------
"--------------------------------------SETS--------------------------------------
set guicursor=
set scrolloff=8

set relativenumber "line numbers moving relatively
set number
set cursorline cursorcolumn

set nohlsearch "search highlight off
set incsearch "cursor moves as soon as typing search
set ignorecase "search ignore cases
set smartcase "search start to not ignore cases if search for uppercase letter

"below command is for vimrc testing while ediing it
autocmd! bufwritepost .vimrc source $MYVIMRC
x" ----------------------------------------------------------------------------
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
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv
" inoremap <C-j> <esc>:m .+1<CR>==i
" inoremap <C-k> <esc>:m .-2<CR>==i
" nnoremap <leader>j :m .+1<CR>==
" nnoremap <leader>k :m .-2<CR>==

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
nnoremap <C-f8> :w<CR>:bd<CR>

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
"-----------------------------------------------------------------------------
" ----------------------------EASYMOTION-------------------------------------------
nmap f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-bd-f2)