return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { "L3MON4D3/LuaSnip",        build = "make install_jsregexp" },
        { 'saadparwaiz1/cmp_luasnip' },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        local cmp = require('cmp')
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<C-k>'] = cmp.mapping.scroll_docs(-4), -- not working on wsl
                ['<C-j>'] = cmp.mapping.scroll_docs(4),  -- use hover twice so we don't need this
                ['<esc>'] = cmp.mapping {
                    i = cmp.mapping.abort(),
                },
                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            cmp.confirm()
                        else
                            cmp.confirm()
                        end
                    else
                        fallback()
                    end
                end, { "i", "s", "c", }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    else
                        fallback()
                    end
                end),
            }),
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp', keyword_length = 1 },
                { name = 'luasnip',  keyword_length = 2 },
                { name = 'nvim_lua', keyword_length = 3 },
                { name = 'buffer',   keyword_length = 3 },
            },
            snippet = {
                expand = function(args)
                    require 'luasnip'.lsp_expand(args.body)
                end
            },
        })
    end
}
