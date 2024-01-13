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
            },
        }

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                local bufopts = { buffer = ev.buf, noremap = true, silent = true }
                vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, bufopts)
                if vim.bo.filetype == 'java' then -- fix for java
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                end
                vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
                vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, bufopts)
                vim.keymap.set('n', 'gws', require('telescope.builtin').lsp_workspace_symbols, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- use it twice to enter hover buffer, :bd or :bp or :bn to get out
                vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, bufopts)
                vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
                vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, bufopts)
                vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
            end,
        })

        -- Use this to override language servers settings or add an extra_on_attach
        local server_settings = require('custom.lsp_servers_settings').server_settings

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        mason_lspconfig.setup_handlers { -- will only run for installed servers
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    ---@diagnostic disable-next-line: unused-local
                    on_attach = function(client, bufnr) -- only extra stuff
                        if server_settings[server_name] and server_settings[server_name].extra_on_attach then
                            server_settings[server_name].extra_on_attach(bufnr)
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
