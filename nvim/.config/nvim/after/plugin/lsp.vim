
" ============== COMPLETION ==============
"set completeopt=menu,menuone,noselect
set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" usefull lsp remaps
"nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap [d <cmd>lua vim.diagnostic.goto_prev({float = false})<CR>
"nnoremap ]d <cmd>lua vim.diagnostic.goto_next({float = false})<CR>
"nnoremap <leader>A <cmd>lua vim.lsp.buf.code_action()<CR>
"nnoremap <leader>Q <cmd>lua vim.diagnostic.setqflist()<CR>
"nnoremap <leader>F <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)<CR>
"nnoremap <leader>R <cmd>lua vim.lsp.buf.rename()<CR>
