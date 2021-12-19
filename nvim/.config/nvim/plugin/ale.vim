" Automatic completion
let g:ale_completion_enabled = 1
" Include the linter name (e.g. 'hack' or 'hhast'), code, and message in errors
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'
" Enable HHAST - this has security implications (see below)
let g:ale_linters = { 'hack': ['hack', 'hhast'] }
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> <leader>A :ALECodeAction<CR>
nnoremap <silent> <leader>R :ALERename<CR>
nnoremap <silent> <leader>D :ALEDetail<CR>
nnoremap <silent> [d :ALEPrevious<CR>
nnoremap <silent> ]d :ALENext<CR>
nnoremap <silent> gr :ALEFindReferences<CR>

" show type on hover in a floating bubble
if v:version >= 801
  set balloonevalterm
  let g:ale_set_balloons = 1
  let balloondelay = 250
endif
