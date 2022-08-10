local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

-- vim signify
nnoremap("[h", "<plug>(signify-prev-hunk)")
nnoremap("]h", "<plug>(signify-next-hunk)")
