return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
        -- LSP Support
        {
            'williamboman/mason.nvim',
            cmd = 'Mason',
        },
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
                'bashls',

                'pyright',
                'ruff_lsp',

                'tsserver',
                'eslint',
                'lemminx',
            },
        }

        -- Use this to override language servers settings.
        local server_settings = require('custom.lsp_servers_settings').server_settings

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        mason_lspconfig.setup_handlers { -- will only run for installed servers
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    ---@diagnostic disable-next-line: unused-local
                    on_attach = function(client, bufnr)
                        require('custom.maps').on_attach(bufnr)
                        if server_settings[server_name] and server_settings[server_name].extra_on_attach then
                            server_settings[server_name].extra_on_attatch(bufnr)
                        end
                    end,
                    settings = (server_settings[server_name] or {}).settings,
                    filetypes = (server_settings[server_name] or {}).filetypes,
                    cmd = (server_settings[server_name] or {}).cmd,
                    root_dir = (server_settings[server_name] or {}).root_dir,
                }
            end
        }
    end,
}
