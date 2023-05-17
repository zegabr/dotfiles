--" ============ACTIVE MAPPINGS============

--" set leader key
vim.keymap.set("n", "<Space>", "<nop>", { desc = '' })
vim.keymap.set("v", "<Space>", "<nop>", { desc = '' })
vim.g.mapleader = " "

--"leader+a select all file, y and p uses system clipboard
vim.keymap.set("n", "<leader>a", "GVgg", { desc = 'select all file' })
vim.keymap.set("n", "Y", "y$", { desc = 'select to the end' })
vim.keymap.set('v', '<leader>p', '"0p', { desc = 'paste last yanked text without losing content' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'paste last yanked text without losing content' })

--"esc with jk
vim.keymap.set("i", "jk", "<ESC>", { desc = 'esc' })
vim.keymap.set("n", "<C-c>", "<ESC>", { desc = 'esc' })

--"replace all ocurrence by typing old and new
vim.keymap.set("n", "<leader>S", ":%s//gIc<Left><Left><Left><Left>", { desc = 'replace snippet normal mode' })

--" same as above, but works in a visual selection
vim.keymap.set("x", "<leader>S", ":s//gIc<Left><Left><Left><Left>", { desc = 'replace snippet visual mode' })

--" alternate between opened buffers
vim.keymap.set("n", "<left>", ":bp<CR>", { desc = 'buffer prev' })
vim.keymap.set("n", "<right>", ":bn<CR>", { desc = 'buffer next' })
--" close close only current buffer
vim.keymap.set("n", "<down>", ":bd<CR>", { desc = 'buffer close' })
--" alternate between current edited file and last edited file
vim.keymap.set("n", "<up>", "<C-^>", { desc = 'buffer last' })

--" quickfix list moves
vim.keymap.set("n", "<C-h>", ":cprev<CR>zz", { desc = 'quickfix list next' })
vim.keymap.set("n", "<C-l>", ":cnext<CR>zz", { desc = 'quickfix list prev' })
vim.keymap.set("n", "<C-q>", ":cclose<CR>zz", { desc = 'quickfix list close' })

--" below command is for vimrc testing while editing it
vim.keymap.set("n", "<Leader><CR>", ":so<cr>", { desc = 'source current lua file' })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = 'save file' })

vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile", { desc = 'test lua file' })

vim.keymap.set('n', '<leader><leader>%', [[:let @+ = fnamemodify(resolve(expand('%:p')), ':~:.')<CR>]],
    { noremap = true, silent = true, desc = 'copy current file name to clipboard' })

--" ============ PASSIVE MAPPINGS============
vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = '' })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = '' })
vim.keymap.set("n", "n", "nzz", { desc = '' })
vim.keymap.set("n", "N", "Nzz", { desc = '' })


vim.keymap.set("n", "Q", "<nop>", { desc = '' })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = 'enter visual mode' })

--" better tabbing
vim.keymap.set("v", "<", "<gv", { desc = '' })
vim.keymap.set("v", ">", ">gv", { desc = '' })

vim.cmd([[
set clipboard=unnamedplus
augroup AUTOSAVE
  au!
  autocmd! InsertLeave,TextChanged,FocusLost * silent! update
augroup END
" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap
]])
