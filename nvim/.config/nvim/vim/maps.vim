" ============MAPPINGS (active mappings)============
nnoremap <Space> <nop>
vnoremap <Space> <nop>
let mapleader = " "

"leader+a select all file, y and p uses system clipboard
set clipboard=unnamedplus
noremap <leader>a GVgg
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
" close close only current buffer
nnoremap <down> :bd<CR>
" alternate between current edited file and last edited file
nnoremap <up> <C-^>

" quickfix list moves
nnoremap <c-h> :cprev<CR>
nnoremap <c-l> :cnext<CR>
