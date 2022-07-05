local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

----- vim fugitive
--" git status
nnoremap("<leader>gs", ":G<CR>")

--" diffget theirs and yours
nnoremap("<leader>gf", ":diffget //2<CR>") -- theirs == top
nnoremap("<leader>gh", ":diffget //3<CR>") -- yours == bottom

-- on git status buffer
-- ds == diff split with file selected (rebasing top diff on bottom diff)
-- dq == go out of diff split mode
-- gq == exit

-- git gutter
nnoremap("[h", ":GitGutterPrevHunk<CR>")
nnoremap("]h", ":GitGutterNextHunk<CR>")
