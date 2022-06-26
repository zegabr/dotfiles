local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

----- vim fugitive
--" git status
nnoremap("<leader>gs", ":G<CR>")

--" diffget left theirs and yours
nnoremap("<leader>gf", ":diffget //2<CR>")
nnoremap("<leader>gh", ":diffget //3<CR>")

------ gv
--" git log
nnoremap("<leader>glo", ":GV<CR>")

--" git log in file
nnoremap("<leader>glf", ":GV!<CR>")

-- git gutter
nnoremap("[c", ":GitGutterPrevHunk<CR>")
nnoremap("]c", ":GitGutterNextHunk<CR>")
