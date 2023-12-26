return {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
        vim.keymap.set('i', '<C-y>', 'copilot#Accept("<CR>")', {
            expr = true,
            replace_keycodes = false
        })
        vim.g.copilot_no_tab_map = true
    end
}
