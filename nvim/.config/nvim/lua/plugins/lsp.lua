return { ----LSP (code editing)
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            { "rafamadriz/friendly-snippets" },
            { 'saadparwaiz1/cmp_luasnip' },

        },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()     -- from luasnip
            local cmp = require('cmp')
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
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
                    { name = 'luasnip',  keyword_length = 2 },     -- from luasnip
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
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
            -- LSP Support
            {
                'williamboman/mason.nvim',
                cmd = 'Mason',
            },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { "folke/neodev.nvim",                opts = {} },
        },
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts, {
                servers = {
                    lua_ls = {
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                },
                                diagnostics = {
                                    globals = { 'vim' },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME
                                    }
                                },
                            }
                        },
                    },
                    bashls = {
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        filetypes = { 'sh', '.bash_aliases', '.bashrc', '.bash_aliases_work', '.profile', '.bash_profile' },
                    },
                    gopls = {
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                            },
                            staticcheck = true,
                        },
                        extra_on_attach = function(bufnr)
                            vim.api.nvim_create_autocmd('BufWritePre', {
                                buffer = bufnr,
                                pattern = '*.go',
                                callback = function()
                                    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
                                end
                            })
                        end
                    },
                    pyright = {

                    },

                    eslint = {
                        capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        extra_on_attach = function(bufnr)
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                buffer = bufnr,
                                pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
                                command = "EslintFixAll",
                            })
                        end
                    },
                },
            })
        end,
        config = function(_, opts)
            require("neodev").setup({})
            require("mason").setup()
            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup {
                ensure_installed = {
                    'lua_ls',
                    'vimls',
                    'bashls',
                },
            }

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local bufopts = { buffer = ev.buf, noremap = true, silent = true }
                    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, bufopts)
                    if vim.bo.filetype == 'java' then     -- fix for java
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                    end
                    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
                    vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, bufopts)
                    vim.keymap.set('n', 'gws', require('telescope.builtin').lsp_workspace_symbols, bufopts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)     -- use it twice to enter hover buffer, :bd or :bp or :bn to get out
                    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
                    vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
                    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
                    vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, bufopts)
                    vim.keymap.set('n', '<leader>d', function() vim.diagnostic.jump({count=1}) end, bufopts)
                end,
            })

            local lspconfig = vim.lsp.config
            for server_name, server_opts in pairs(opts.servers or {}) do
                lspconfig(server_name, server_opts)
            end
        end,
    },
}
