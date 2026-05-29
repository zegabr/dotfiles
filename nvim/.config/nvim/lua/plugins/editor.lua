-- Editor (things I'll hardly modify)
vim.pack.add({
    'https://github.com/zegabr/toolbox.nvim',
    'https://github.com/ntpeters/vim-better-whitespace',
    { src = 'https://github.com/j-hui/fidget.nvim', version = 'v1.0.0' },
    'https://github.com/uga-rosa/ccc.nvim',
    'https://github.com/mbbill/undotree',
    'https://github.com/tpope/vim-obsession',
    'https://github.com/tpope/vim-commentary',
    'https://github.com/tpope/vim-surround',
})

-- toolbox.nvim
vim.keymap.set('n', '<leader><leader>%', ":CopyFilename<CR>",
    { noremap = true, silent = true, desc = 'copy current file name to clipboard' })
vim.keymap.set('n', '<leader>S', ":SearchReplaceSnippetFile<CR>",
    { noremap = true, silent = true, desc = 'global replace snippet normal mode' })
vim.keymap.set("x", "<leader>S", ":SearchReplaceSnippetRange<CR>",
    { desc = 'global replace snippet visual mode' })
vim.keymap.set("x", "<leader>m", ":MultiLineMacro ", { desc = 'run macro per line on visual mode' })

-- fidget.nvim
require("fidget").setup({})

-- undotree
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

--vim store session :Obsession TODO -> remember to add *Session.vim it to your .git/info/exclude (my 'vs' bash alias already does that for me)
-- <count>gcc | gcgc | visual gc
---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
-- simplest way to use surround:
-- TO ADD PAIR:
-- 1) select with any visual mode.
-- 2) press S<closing pair> or St<tagname>
-- TO DELETE PAIR:
-- 1) ds<surrounding pair>
-- TO CHANGE PAIR:
-- 1) cs<pair to be changed><new closing pair>
