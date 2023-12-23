return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        -- { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'rafamadriz/friendly-snippets' },

    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<C-j>'] = cmp.mapping.scroll_docs(4),
                ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                ['<esc>'] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    -- c = cmp.mapping.close(),
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
                { name = 'buffer',   keyword_length = 3 },
                { name = 'luasnip',  keyword_length = 2 },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
        })
    end
}
