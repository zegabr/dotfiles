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

return {
    ---@diagnostic disable-next-line: unused-local
    on_attach = function(client, bufnr)
        local bufopts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, bufopts)
        if vim.bo.filetype == 'java' then -- fix for java
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        end
        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
        vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, bufopts)
        vim.keymap.set('n', 'gws', require('telescope.builtin').lsp_workspace_symbols, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- sometimes need to use it twice to move inside it
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, bufopts)
        vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, bufopts)
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
    end,
}
