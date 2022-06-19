vim.cmd([[
" git status
:nnoremap <leader>gs :G<CR>

" git branch checkout/management
:nnoremap  :GBranches<CR>

" diffget left theirs ans yours
nmap <leader>gf :diffget //2<CR>
nmap <leader>gh :diffget //3<CR>

" git log
nmap <leader>glo :GV<CR>

" git log in file
"nmap <leader>glf :GV!<CR>
]])
