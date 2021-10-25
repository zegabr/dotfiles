" usefull lsp remaps
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev({float = false})<CR>
nnoremap ]d <cmd>lua vim.diagnostic.goto_next({float = false})<CR>
"nnoremap <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR> " TODO: check how to use quickfixlist vs locationlist before using this
nnoremap <leader>F <cmd>lua vim.lsp.buf.formatting_sync(nil, 100)<CR>
nnoremap <leader>R <cmd>lua vim.lsp.buf.rename()<CR>

" ============== COMPLETION ==============
set completeopt=menu,menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
