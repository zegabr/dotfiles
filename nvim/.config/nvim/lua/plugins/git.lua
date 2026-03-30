local is_git_repo = function()
    local cwd = vim.fn.getcwd()
    local git_dir = vim.fn.expand(cwd .. '/.git')
    return vim.fn.isdirectory(git_dir) == 1
end

return {                            -- specific plugins to work with git, currently not for mercurial or jujutsu
    {
        'ruifm/gitlinker.nvim',     -- get premalink by <leader>gy (works in visuali mode)
        keys = '<leader>gy',
        enabled = is_git_repo(),
        config = function()
            require("gitlinker").setup({
                mappings = "<leader>gy",
            })
        end
    },

    {
        'mhinz/vim-signify',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.keymap.set("n", "[h", "<plug>(signify-prev-hunk)", { desc = 'prev hunk' })
            vim.keymap.set("n", "]h", "<plug>(signify-next-hunk)", { desc = 'next hunk' })
        end,
    },

}
