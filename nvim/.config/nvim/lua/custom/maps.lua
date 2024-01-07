--" ============ACTIVE MAPS============
vim.keymap.set("n", "<Space>", "<nop>", { silent = true, desc = '' })
vim.keymap.set("x", "<Space>", "<nop>", { silent = true, desc = '' })
vim.keymap.set("n", "Q", "<nop>", { desc = 'remove Q mapping' })

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>a", "GVgg", { silent = true, desc = 'select all file' })
vim.keymap.set("n", "Y", "y$", { silent = true, desc = 'yank to the end' })
vim.keymap.set('x', '<leader>p', '"0p', { silent = true, desc = 'paste last yanked text without losing content' })
vim.keymap.set('x', '<leader>p', [["_dP]], { silent = true, desc = 'paste last yanked text without losing content' })
vim.keymap.set("n", "<leader>w", ":wa<CR>", { desc = 'save all files' })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = 'enter visual-block mode' })
vim.keymap.set("n", "gv", "`[v`]", { desc = 'select last pasted text' })

vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = 'esc' })
vim.keymap.set("n", "<C-c>", "<ESC>", { silent = true, desc = 'esc' })

-- this is how i adapted with using bufferline, this way i can quickly manage opened buffers iterating between them and deleting the ones i don't want
vim.keymap.set("n", "<left>", ":bp<CR>", { desc = 'buffer prev' })
vim.keymap.set("n", "<right>", ":bn<CR>", { desc = 'buffer next' })
vim.keymap.set("n", "<down>", ":bd<CR>", { desc = 'buffer close' })
vim.keymap.set("n", "<up>", "<C-^>", { desc = 'buffer last' })

vim.keymap.set("n", "<C-h>", ":cprev<CR>zz", { desc = 'quickfix list next' })
vim.keymap.set("n", "<C-l>", ":cnext<CR>zz", { desc = 'quickfix list prev' })
vim.keymap.set("n", "<C-q>", ":cclose<CR>zz", { desc = 'quickfix list close' })

vim.keymap.set("n", "<Leader><CR>", ":so<cr>", { desc = 'source current lua file' })
vim.keymap.set("n", "+", "<C-a>", { silent = true, desc = 'increment' })
vim.keymap.set("n", "-", "<C-x>", { silent = true, desc = 'decrement' })
