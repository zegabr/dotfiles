local wilder = require('wilder')

wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({
            language = 'python',
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.python_search_pipeline({
            -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
            pattern = wilder.python_fuzzy_pattern(),
            -- omit to get results in the order they appear in the buffer
            sorter = wilder.python_difflib_sorter(),
            -- can be set to 're2' for performance, requires pyre2 to be installed
            -- see :h wilder#python_search() for more details
            engine = 're2',
        })
    )
})

wilder.set_option('renderer', wilder.renderer_mux({
    [':'] = wilder.popupmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
        left = {
            ' ',
            wilder.popupmenu_devicons()
        },
        right = {
            ' ',
            wilder.popupmenu_scrollbar()
        },
    }),
    ['/'] = wilder.wildmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
    }),
}))
