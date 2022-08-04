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

local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap

-- toggle
nnoremap("<leader><leader>u", ":UndotreeToggle<CR>")

--" undo break points
inoremap(",", ",<c-g>u")
inoremap("?", "?<c-g>u")
inoremap("!", "!<c-g>u")
inoremap(".", ".<c-g>u")
inoremap(";", ";<c-g>u")
