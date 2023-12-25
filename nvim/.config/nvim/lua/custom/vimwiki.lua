return {
    'vimwiki/vimwiki',
    ft = 'md',
    init = function()
        -- this should run before load
        vim.g.vimwiki_map_prefix = '<Leader><Leader>v'
        vim.g.vimwiki_markdown_link_ext = 1
    end,
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
