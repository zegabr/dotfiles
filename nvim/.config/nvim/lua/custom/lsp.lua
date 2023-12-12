return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'telescope.nvim' },
        -- LSP Support
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- { 'folke/neodev.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        -- { 'hrsh7th/cmp-nvim-lua' },
        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        require("mason").setup()
        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup {
            ensure_installed = {
                'lua_ls',
                'vimls',
                'pyright',
                'ruff_lsp',
                'tsserver',
                'eslint',
            },
        }

        -- Use this to override language servers settings.
        -- Also using this, you should add all servers you want to attach to the list.
        -- Did this becuase I didn't want to auto setup jdtls, as i'm usin nvim-jdtls for that.
        -- removing a server from the table below will assure it is not set automatically
        local servers_settings = {
            vimls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        }
                    }
                },
            },
            pyright = {},
            ruff_lsp = {},
            tsserver = {},
            gopls = {
                cmd = { "gopls", "serve" },
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                    },
                    staticcheck = true,
                },
                extra_on_attatch = function()
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        pattern = '*.go',
                        callback = function()
                            vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
                        end
                    })
                end
            },
            rust_analyzer = {
                cmd = { "rustup", "run", "stable", "rust-analyzer" },
                settings = {
                    rust = {
                        unstable_features = true,
                        build_on_save = false,
                        all_features = true,
                    },
                }
            },
            eslint = {
                extra_on_attatch = function()
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        --buffer = bufnr,
                        pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
                        command = "EslintFixAll",
                    })
                end
            },
        }

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        for server_name in pairs(servers_settings) do
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = function()
                    require('custom.utils').on_attach()
                    if servers_settings[server_name] ~= nil and servers_settings[server_name].extra_on_attach ~= nil then
                        servers_settings[server_name].extra_on_attatch()
                    end
                end,
                settings = (servers_settings[server_name] or {}).settings,
                filetypes = (servers_settings[server_name] or {}).filetypes,
                cmd = (servers_settings[server_name] or {}).cmd,
                root_dir = (servers_settings[server_name] or {}).root_dir,
            }
        end
    end,
}
