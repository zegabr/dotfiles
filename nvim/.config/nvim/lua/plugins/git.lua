local is_git_repo = function()
    local cwd = vim.fn.getcwd()
    local git_dir = vim.fn.expand(cwd .. '/.git')
    return vim.fn.isdirectory(git_dir) == 1
end

vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/ruifm/gitlinker.nvim',
    'https://github.com/mhinz/vim-signify',
})

if is_git_repo() then
    require("gitlinker").setup({
        mappings = "<leader>gy",
    })
end

vim.keymap.set("n", "[h", "<plug>(signify-prev-hunk)", { desc = 'prev hunk' })
vim.keymap.set("n", "]h", "<plug>(signify-next-hunk)", { desc = 'next hunk' })
