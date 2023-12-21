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
            require('neoclip').setup({
                keys = {
                    telescope = {
                        i = {
                            paste_behind = '<cr>', -- paste on select, why not?
                            paste = '<c-p>',       -- this is pasting at end of line (TODO: test on linux)
                        },
                    },
                },
            })
            vim.keymap.set("n", '"', require('telescope').extensions.neoclip.default, { desc = 'Telescope Neoclip' })
        end,
    },

    { 'ntpeters/vim-better-whitespace' }, --trim whitespace with :StripWhiteSpace
    { 'matze/vim-move' },                 --alt j/k moves selected lines normal and visual mode
    { 'tpope/vim-obsession', },           --vim store session :Obsession TODO -> remember to add *Session.vim it to your .git/info/exclude (my 'vs' bash alias already does that for me)

    -- Comments
    { 'tpope/vim-commentary', }, -- <count>gcc | gcgc | visual gc

    -- Surround
    { 'tpope/vim-surround' }, ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to use it:
    -- TO ADD PAIR:
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- TO DELETE PAIR:
    -- 1) ds<surrounding pair>
    -- TO CHANGE PAIR:
    -- 1) cs<pair to be changed><new closing pair>
    {
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
            })
            vim.keymap.set("n", "<Leader>e", ":Oil<CR>", { desc = "open file tree" })
        end
    },
}
