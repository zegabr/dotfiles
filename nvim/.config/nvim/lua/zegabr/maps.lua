--" ============ACTIVE MAPPINGS============

--" set leader key
vim.keymap.set("n", "<Space>", "<nop>")
vim.keymap.set("v", "<Space>", "<nop>")
vim.g.mapleader = " "

--"leader+a select all file, y and p uses system clipboard
vim.keymap.set("n", "<leader>a", "GVgg")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("x", "<leader>p", "\"_dp")

--"esc with jk
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<C-c>", "<ESC>")

--"replace all ocurrence by typing old and new
vim.keymap.set("n", "<leader>S", ":%s//gIc<Left><Left><Left><Left>")

--" same as above, but works in a visual selection
vim.keymap.set("x", "<leader>S", ":s//Ic<Left><Left><Left>")

--" alternate between opened buffers
vim.keymap.set("n", "<left>", ":bp<CR>")
vim.keymap.set("n", "<right>", ":bn<CR>")
--" close close only current buffer
vim.keymap.set("n", "<down>", ":bd<CR>")
--" alternate between current edited file and last edited file
vim.keymap.set("n", "<up>", "<C-^>")

--" quickfix list moves
vim.keymap.set("n", "<C-h>", ":cprev<CR>zz")
vim.keymap.set("n", "<C-l>", ":cnext<CR>zz")
vim.keymap.set("n", "<C-q>", ":cclose<CR>zz")

--" below command is for vimrc testing while editing it
vim.keymap.set("n", "<Leader><CR>", "<cmd>luafile %<cr>")

--" ============ PASSIVE MAPPINGS============
vim.keymap.set("n", "<C-j>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")


vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>v", "<C-v>")

--" better tabbing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.cmd([[
set clipboard=unnamedplus
augroup AUTOSAVE
  au!
  autocmd! InsertLeave,TextChanged,FocusLost * silent! update
augroup END
" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap
]])
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile")
