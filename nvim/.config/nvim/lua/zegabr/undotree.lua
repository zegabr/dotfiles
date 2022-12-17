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
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
