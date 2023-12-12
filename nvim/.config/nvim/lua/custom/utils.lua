local on_attach = function(_, bufnr)
    local bufopts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    -- vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, bufopts)
    -- vim.keymap.set('n', 'gw', require('telescope.builtin').lsp_workspace_symbols, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
end
return {
    on_attach = on_attach,
}
