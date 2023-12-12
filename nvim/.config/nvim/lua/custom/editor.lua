return {
    {
        'mhinz/vim-signify',
        config = function()
            vim.keymap.set("n", "[h", "<plug>(signify-prev-hunk)", { desc = 'prev hunk' })
            vim.keymap.set("n", "]h", "<plug>(signify-next-hunk)", { desc = 'next hunk' })
        end,
    },
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require('neoclip').setup()
            vim.keymap.set("n", '"', require('telescope').extensions.neoclip.default, { desc = 'Telescope Neoclip' })
        end,
    },
    { 'ntpeters/vim-better-whitespace' }, --trim whitespace with :StripWhiteSpace
    { 'matze/vim-move' },                 --alt j/k moves selected lines normal and visual mode
    { 'tpope/vim-obsession', },           --vim store session :Obsession TODO -> remember to add *Session.vim it to your .git/info/exclude
    {
        'ruifm/gitlinker.nvim',           -- get premalink by <leader>gy (works in visuali mode)
        config = function() require("gitlinker").setup() end
    },

    -- Comments
    { 'tpope/vim-commentary', }, -- gcc | gcgc | visual gc

    -- Surround
    { 'tpope/vim-surround' }, ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to  i,s:
    -- to add pair
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- to delete pair
    -- 1) ds<surrounding pair>
    -- to change pair
    -- 1) cs<pair to be changed><new closing pair>
    { 'f-person/git-blame.nvim' },
}
