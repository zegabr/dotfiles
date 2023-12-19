return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
        -- LSP Support
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        -- { 'folke/neodev.nvim' },
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
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
                'bashls',
            },
        }

        -- Use this to override language servers settings.
        local servers_settings = {
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
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                            }
                        },
                    }
                },
            },
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
                extra_on_attatch = function(bufnr)
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
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
                extra_on_attatch = function(bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
                        command = "EslintFixAll",
                    })
                end
            },
            bashls = {
                filetypes = { 'sh', '.bash_aliases', '.bashrc', '.bash_aliases_work', },
            }
        }

        local using_nvim_jdtls = true
        if not using_nvim_jdtls then
            require('java').setup()
        end

        local externally_attached = { -- will not be setup via mason_lspconfig
            jdtls = using_nvim_jdtls,
        }

        mason_lspconfig.setup_handlers { -- will only run for installed servers
            function(server_name)
                if externally_attached[server_name] ~= nil and externally_attached[server_name] == true then
                    return -- make sure externally_attached servers are not attached by lspconfig
                end
                require('lspconfig')[server_name].setup {
                    capabilities = require('cmp_nvim_lsp').default_capabilities(),
                    on_attach = function()
                        local bufnr = vim.api.nvim_get_current_buf()
                        require('custom.maps').on_attach(bufnr)
                        if servers_settings[server_name] ~= nil and servers_settings[server_name].extra_on_attach ~= nil then
                            servers_settings[server_name].extra_on_attatch(bufnr)
                        end
                    end,
                    settings = (servers_settings[server_name] or {}).settings,
                    filetypes = (servers_settings[server_name] or {}).filetypes,
                    cmd = (servers_settings[server_name] or {}).cmd,
                    root_dir = (servers_settings[server_name] or {}).root_dir,
                }
            end
        }
    end,
}
