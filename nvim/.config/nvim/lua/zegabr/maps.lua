local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap
local xnoremap = keymap.xnoremap
local vnoremap = keymap.vnoremap
local inoremap = keymap.inoremap

--" ============MAPPINGS (active mappings)============

--" set leader key
nnoremap("<Space>", "<nop>")
vnoremap("<Space>", "<nop>")
vim.g.mapleader = " "

--"leader+a select all file, y and p uses system clipboard
nnoremap("<leader>a", "GVgg")
nnoremap("Y", "y$")
xnoremap("<leader>p", "\"_dp")

--"esc with jk
inoremap("jk", "<ESC>")
nnoremap("<C-c>", "<ESC>")

--"replace all ocurrence by typing old and new
nnoremap("<leader>S", ":%s//gIc<Left><Left><Left><Left>")

--" same as above, but works in a visual selection
xnoremap("<leader>S", ":s//Ic<Left><Left><Left>")

--" alternate between opened buffers
nnoremap("<left>", ":bp<CR>")
nnoremap("<right>", ":bn<CR>")
--" close close only current buffer
nnoremap("<down>", ":bd<CR>")
--" alternate between current edited file and last edited file
nnoremap("<up>", "<C-^>")

--" quickfix list moves
nnoremap("<C-h>", ":cprev<CR>zz")
nnoremap("<C-l>", ":cnext<CR>zz")
nnoremap("<C-q>", ":cclose<CR>zz")

--" below command is for vimrc testing while editing it
nnoremap("<Leader><CR>", "<cmd>luafile %<cr>")

--" ============SETS (and passive mappings)============

nnoremap("Q", "<nop>")
nnoremap("<leader>v", "<C-v>")

--" better tabbing
vnoremap("<", "<gv")
vnoremap(">", ">gv")

vim.cmd([[
set clipboard=unnamedplus
augroup AUTOSAVE
  au!
  autocmd! InsertLeave,TextChanged,FocusLost * silent! write
augroup END
" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap
]])

nnoremap("<leader><leader>t", "<Plug>PlenaryTestFile")
