local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

----- vim fugitive
--" git status
nnoremap("<leader>gs", ":G<CR>")

--" diffget theirs and yours
nnoremap("<leader>gf", ":diffget //2<CR>") -- theirs == left
nnoremap("<leader>gh", ":diffget //3<CR>") -- yours == right

-- on git status buffer
-- dv == diff split with file selected
-- dq == go out of diff split mode
-- gq == exit

-- git gutter
nnoremap("[c", ":GitGutterPrevHunk<CR>")
nnoremap("]c", ":GitGutterNextHunk<CR>")
