local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<esc>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
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
                cmp.select_next_item()
            else
                fallback()
            end
        end),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
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
    experimental = { ghost_text = false, },
    window = { documentation = cmp.config.window.bordered() },
})

local on_attach = function(_, bufnr)
    local bufopts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    -- vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, bufopts)
    -- vim.keymap.set('n', 'gw', require('telescope.builtin').lsp_workspace_symbols, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

for server_name in pairs(servers_settings) do
    require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = function()
            on_attach()
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
-- mason_lspconfig.setup_handlers { -- will only run for installed servers
--     function(server_name)
--     end
-- }
return {
    on_attach = on_attach,
}
