" ============MAPPINGS (active mappings)============

"leader+a select all file, y and p uses system clipboard
set clipboard=unnamedplus
noremap <leader>a GVgg
nnoremap Y y$
" cycle through yank history
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

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
nnoremap <C-h> :cprev<CR>zz
nnoremap <C-l> :cnext<CR>zz
nnoremap <C-q> :cclose<CR>zz

" below command is for vimrc testing while editing it
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
autocmd! bufwritepost ~/.config/nvim/*.vim source $MYVIMRC
autocmd! bufwritepost ~/.config/nvim/*.lua source $MYVIMRC
autocmd CursorHold * update

" css to inline style
let g:csstoinline_no_mapping = 1
nmap <leader>is <Plug>ToInlineN
xmap <leader>is <Plug>ToInlineV
nmap <leader>cs <Plug>FromInlineN
xmap <leader>cs <Plug>FromInlineV

" open file even if it does not exists
map gf :edit <cfile><cr>
