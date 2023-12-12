return {
    'vimwiki/vimwiki',
    config = function()
        vim.cmd([[
                set nocompatible
                filetype plugin on
                syntax on
                let g:vimwiki_list = [{'path': '~/notes/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                       \ 'links_space_char': '_'}]
            ]])
    end
}
