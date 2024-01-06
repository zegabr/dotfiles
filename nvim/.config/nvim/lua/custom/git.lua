return { -- specific plugins to work with git, doesn't allow mercurial

    {
        'ruifm/gitlinker.nvim', -- get premalink by <leader>gy (works in visuali mode)
        keys = '<leader>gy',
        config = function()
            require("gitlinker").setup({
                mappings = "<leader>gy",
            })
        end
    },

    {
        'f-person/git-blame.nvim',
        cmd = 'GitBlameToggle',
        config = function()
            require('gitblame').setup({ enabled = false, })
            -- :GitBlameToggle when needed
        end
    },
    {
        'tpope/vim-fugitive',
        config = function()
            -- if this don't work, try removing vim session
            vim.keymap.set("n", "<leader>G", ":Git<CR>", { desc = 'Git fugitive' })
        end
    },
}
