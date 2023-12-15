--" ============ACTIVE MAPS============
vim.keymap.set("n", "<Space>", "<nop>", { desc = '' })
vim.keymap.set("v", "<Space>", "<nop>", { desc = '' })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>a", "GVgg", { desc = 'select all file' })
vim.keymap.set("n", "Y", "y$", { desc = 'select to the end' })
vim.keymap.set('v', '<leader>p', '"0p', { desc = 'paste last yanked text without losing content' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'paste last yanked text without losing content' })
vim.keymap.set("i", "jk", "<ESC>", { desc = 'esc' })
vim.keymap.set("n", "<C-c>", "<ESC>", { desc = 'esc' })
vim.keymap.set("n", "<leader>S", ":%s//gIc<Left><Left><Left><Left>", { desc = 'replace snippet normal mode' })
vim.keymap.set("x", "<leader>S", ":s//gIc<Left><Left><Left><Left>", { desc = 'replace snippet visual mode' })
vim.keymap.set("n", "<left>", ":bp<CR>", { desc = 'buffer prev' })
vim.keymap.set("n", "<right>", ":bn<CR>", { desc = 'buffer next' })
vim.keymap.set("n", "<down>", ":bd<CR>", { desc = 'buffer close' })
vim.keymap.set("n", "<up>", "<C-^>", { desc = 'buffer last' })
vim.keymap.set("n", "<C-h>", ":cprev<CR>zz", { desc = 'quickfix list next' })
vim.keymap.set("n", "<C-l>", ":cnext<CR>zz", { desc = 'quickfix list prev' })
vim.keymap.set("n", "<C-q>", ":cclose<CR>zz", { desc = 'quickfix list close' })
vim.keymap.set("n", "<Leader><CR>", ":so<cr>", { desc = 'source current lua file' })
vim.keymap.set("n", "+", "<C-a>", { desc = 'increment' })
vim.keymap.set("n", "-", "<C-x>", { desc = 'decrement' })
vim.g.vimwiki_map_prefix = '<Leader><Leader>v'
vim.keymap.set("n", "<leader>w", ":wa<CR>", { desc = 'save all files' })
-- vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile", { desc = 'test lua file' })
vim.keymap.set('n', '<leader><leader>%', [[:let @+ = fnamemodify(resolve(expand('%:p')), ':~:.')<CR>]],
    { noremap = true, silent = true, desc = 'copy current file name to clipboard' })
--" ============ PASSIVE MAPS============
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'passive centering' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'passive centering' })
vim.keymap.set("n", "n", "nzz", { desc = 'passive centering' })
vim.keymap.set("n", "N", "Nzz", { desc = 'passive centering' })
vim.keymap.set("n", "Q", "<nop>", { desc = 'remove Q mapping' })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = 'enter visual-block mode' })
vim.keymap.set("n", "gv", "`[v`]", { desc = 'select last pasted text' })
vim.keymap.set("v", "<", "<gv", { desc = 'passive tabbing on visual mode' })
vim.keymap.set("v", ">", ">gv", { desc = 'passive tabbing on visual mode' })


return {
    on_attach = function(_, bufnr)
        local bufopts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
        -- vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, bufopts)
        -- vim.keymap.set('n', 'gw', require('telescope.builtin').lsp_workspace_symbols, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, bufopts)
        vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
        vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, bufopts)
        vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
    end,
}
