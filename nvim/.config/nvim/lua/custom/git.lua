local is_git_repo = function()
    local cwd = vim.fn.getcwd()
    local git_dir = vim.fn.expand(cwd .. '/.git')
    return vim.fn.isdirectory(git_dir) == 1
end

return { -- specific plugins to work with git, doesn't allow mercurial

    {
        'ruifm/gitlinker.nvim', -- get premalink by <leader>gy (works in visuali mode)
        keys = '<leader>gy',
        enabled = is_git_repo(),
        config = function()
            require("gitlinker").setup({
                mappings = "<leader>gy",
            })
        end
    },

    {
        'f-person/git-blame.nvim',
        cmd = 'GitBlameToggle',
        enabled = is_git_repo(),
        config = function()
            require('gitblame').setup({ enabled = false, })
            -- :GitBlameToggle when needed
        end
    },
}
