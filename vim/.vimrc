"---------------Default settings---------
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
syntax on
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
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile

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

"Remove trailing space on save
autocmd BufWritePre * %s/\s\s+$//e

"------------Mappings--------------
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

"esc and save in jk 
inoremap jk <ESC>

"go up, go down, 
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"toggle word case
inoremap <c-u> <esc>lviw~<esc>
nnoremap <c-u> viw~<esc>

"normal mode arrow keys, ident, save&quit, last edit pos, save
"nnoremap <Right> mijkgg=G'izz
"nnoremap <Left> :wq<CR>
"nnoremap <up> <C-o>
"nnoremap <down> :w<CR>

"inoremap <Right> <nop>
"inoremap <Left> <nop>
"inoremap <Up> <nop>
"inoremap <Down> <nop>

"vnoremap <Right> <nop>
"vnoremap <Left> <nop>
"vnoremap <Up> <nop>
"vnoremap <Down> <nop>

nnoremap <Right> <nop>
nnoremap <Left> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

"center things
"nnoremap G Gzz
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap } }zz
"nnoremap { {zz

"replace all ocurrence by typing old and new
nnoremap S :%s//gI<Left><Left><Left>
"replace ocurrences of last searched word
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left>

" alternate between opened buffers
nnoremap <f7> :bp<CR>
nnoremap <f8> :bn<CR>
" close only current buffer
nnoremap <C-f8> :w<CR>:bd<CR>

" terminal
nnoremap <C-t> :term<CR>
"-------------- C/C++------------
function! CPPSET()
set cindent
set textwidth=0
set nowrap
set ts=4 
set sw=4 
set sts=4 
set expandtab 
set autoindent

"abbreviations here
" does not work with coc pairs
":iabbrev sp ' '
":iabbrev pl '\n'
:iabbrev ee &
:iabbrev adn and
:iabbrev endk endl
:iabbrev enld endl

endfunction

"------------------- Python--------
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

"--------------autocmd defaults-------
"below command is for vimrc testing while ediing it
autocmd! bufwritepost .vimrc source $MYVIMRC
autocmd! bufwritepre,bufread *.cpp :normal gg=G
filetype on
autocmd! FileType python call PYSET() 
autocmd! Filetype cpp call CPPSET()
autocmd! Filetype c call CPPSET()

"-----------------Plugins installation--------

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

" git vim fugitive
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

" ----------use gruvbox theme ----- 
colorscheme gruvbox
let g:airline_theme='minimalist'
set background=dark

"----------- FuzzyFinder FZF settings ---- 
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

"------------ NerdCommenter Setings ---
filetype plugin on
imap <C-_> <ESC><Plug>NERDCommenterToggle
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

"-------------- Git gutter -----
set updatetime=100

" ------------------Git Fugitive -------
" git status
nnoremap <leader>gs :G<CR>
" git checkout
nnoremap <leader>gb :GBranches<CR>
" diffget left theirs ans yours
nmap <leader>gf :diffget //2<CR>
nmap <leader>gh :diffget //3<CR>

" ------------------undotree ---- 
nnoremap <F5> :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2

"------------------- Coc settings ------
let g:coc_global_extensions = [
			\'coc-json',
			\'coc-fzf-preview',
			\'coc-explorer',
			\'coc-sh',
			\'coc-pairs',
			\'coc-spell-checker'
\]

" this must fix possible issues with pyright not finding project root
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap <leader>af  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"--------------------- coc-explorer--------------------
nnoremap <space>e :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

