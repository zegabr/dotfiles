local keymap = require('zegabr.keymap')
local noremap = keymap.nnoremap
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

noremap("<Leader>e", ":Ex<cr>")
-- TODO: go :h netrw
-- learn how to use netrw to:
-- - create file near current file
-- - delete file
-- - delete folder
-- - move file
-- - move folder
-- - copy folder to other place
