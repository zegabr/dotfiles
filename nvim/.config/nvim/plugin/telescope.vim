"telescope mappings TODO: add to telescope.lua
nnoremap <C-p> <cmd>lua require('zegabr.telescope-config').project_files()<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
