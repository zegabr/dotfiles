return { -- Editor (things I'll hardly modify)
    {
        'zegabr/toolbox.nvim',
        config = function()
            vim.keymap.set('n', '<leader><leader>%', ":CopyFilename<CR>",
                { noremap = true, silent = true, desc = 'copy current file name to clipboard' })
            vim.keymap.set('n', '<leader>S', ":SearchReplaceSnippetFile<CR>",
                { noremap = true, silent = true, desc = 'global replace snippet normal mode' })
            vim.keymap.set("x", "<leader>S", ":SearchReplaceSnippetRange<CR>",
                { desc = 'global replace snippet visual mode' })
            vim.keymap.set("x", "<leader>m", ":MultiLineMacro ", { desc = 'run macro per line on visual mode' })
        end
    },
    { 'ntpeters/vim-better-whitespace' },     --trim whitespace with :StripWhiteSpace
    {
        "j-hui/fidget.nvim",
        tag = "v1.0.0",
        opts = {
            -- options
        },
    },

    -- color picker
    { "uga-rosa/ccc.nvim" },

    {     -- this does not exists on other editors
        'mbbill/undotree',
        config = function()
            vim.cmd([[
            let g:undotree_WindowLayout = 2
            if has("persistent_undo")
                set undodir=$HOME."/.undodir"
                set undofile
            endif
        ]])
            vim.opt.swapfile = false
            vim.opt.backup = false
            vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
            vim.opt.undofile = true
            -- toggle
            vim.keymap.set("n", "<leader><leader>u", vim.cmd.UndotreeToggle)

            --" undo break points
            vim.keymap.set("i", ",", ",<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
            vim.keymap.set("i", "?", "?<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
            vim.keymap.set("i", "!", "!<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
            vim.keymap.set("i", ".", ".<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
            vim.keymap.set("i", ";", ";<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
        end,
    },
    { 'tpope/vim-obsession', },  --vim store session :Obsession TODO -> remember to add *Session.vim it to your .git/info/exclude (my 'vs' bash alias already does that for me)
    { 'tpope/vim-commentary', }, -- <count>gcc | gcgc | visual gc
    { 'tpope/vim-surround' },    ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to use surround:
    -- TO ADD PAIR:
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- TO DELETE PAIR:
    -- 1) ds<surrounding pair>
    -- TO CHANGE PAIR:
    -- 1) cs<pair to be changed><new closing pair>
}
