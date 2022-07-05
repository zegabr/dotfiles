local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

----- vim fugitive
--" git status
nnoremap("<leader>gs", ":G<CR>")

--" diffget theirs and yours
nnoremap("<leader>gf", ":diffget //2<CR>")
nnoremap("<leader>gh", ":diffget //3<CR>")

-- git gutter
nnoremap("[c", ":GitGutterPrevHunk<CR>")
nnoremap("]c", ":GitGutterNextHunk<CR>")
