return {
    'stevearc/oil.nvim',
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
            delete_to_trash = true,
            use_default_keymaps = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-c>"] = "actions.close",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["g."] = "actions.toggle_hidden",
            },
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 0,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
        })
        vim.keymap.set("n", "<Leader>e", require('oil').open_float, { desc = "open file tree" })
    end
}
