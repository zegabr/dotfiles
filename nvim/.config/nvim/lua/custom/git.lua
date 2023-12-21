return { -- specific plugins to work with git, doesn't allow mercurial

    {
        'ruifm/gitlinker.nvim', -- get premalink by <leader>gy (works in visuali mode)
        config = function()
            require("gitlinker").setup({
                mappings = "<leader>gy",
            })
        end
    },

    {
        'f-person/git-blame.nvim',
        config = function()
            require('gitblame').setup({ enabled = false, })
            -- :GitBlameToggle when needed
        end
    },
}
