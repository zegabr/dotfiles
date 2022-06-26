vim.cmd([[
filetype plugin on
let g:NERDCreateDefaultMappings = 0
]])

local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local inoremap = keymap.inoremap

nnoremap("<C-_>", "<Plug>NERDCommenterToggle")
inoremap("<C-_>", "<ESC><Plug>NERDCommenterToggle")
vnoremap("<C-_>", "<Plug>NERDCommenterToggle<CR>gv")

