return {
    'lervag/vimtex',
    ft = 'tex',
    config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_method = 'tectonic'
        vim.cmd([[
                let g:vimtex_compiler_tectonic = {
                    \ 'build_dir' : '',
                    \ 'hooks' : [],
                    \ 'options' : [
                    \   '--keep-logs',
                    \   '--synctex'
                    \ ],
                    \}
            ]])
    end
}
