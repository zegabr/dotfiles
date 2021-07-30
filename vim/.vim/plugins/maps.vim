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
