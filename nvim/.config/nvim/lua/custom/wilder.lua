return {
    'gelguy/wilder.nvim',
    dependencies = { 'romgrk/fzy-lua-native' },
    build = ':UpdateRemotePlugins',
    init = function()
        vim.opt.wildignore = {
            "*.pyc",
            "*_build/*",
            "**/coverage/*",
            "**/node_modules/*",
            "**/android/*",
            "**/ios/*",
            "**/.git/*",
        }
    end,
    config = function()
        local wilder = require('wilder')
        wilder.setup({ modes = { ':', '/', '?' } })
        -- Disable Python remote plugin
        wilder.set_option('use_python_remote_plugin', 0)

        wilder.set_option('pipeline', {
            wilder.branch(
                wilder.cmdline_pipeline({
                    fuzzy = 1,
                    fuzzy_filter = wilder.lua_fzy_filter(),
                }),
                wilder.vim_search_pipeline()
            )
        })
        wilder.set_option('renderer', wilder.renderer_mux({
            [':'] = wilder.popupmenu_renderer({
                highlighter = wilder.lua_fzy_highlighter(),
                right = {
                    ' ',
                    wilder.popupmenu_scrollbar()
                },
            }),
            ['/'] = wilder.wildmenu_renderer({
                highlighter = wilder.lua_fzy_highlighter(),
            }),
        }))
    end
}
