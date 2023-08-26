local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed({
    'lua_ls',
    'vimls',
    'pyright',
})
lsp.set_preferences({
    -- comment this if you want to show diagnostics icons
    sign_icons = {},
    -- setting this to false so it shows the message inline
    configure_diagnostics = false,
    set_lsp_keymaps = false,
})
local cmp = require('cmp')
local luasnip = require('luasnip')
lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<esc>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ['<CR>'] = cmp.mapping(
            cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            { "i", "c" }
        ),
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
    experimental = {
        ghost_text = false,
    },
    window = {
        documentation = cmp.config.window.bordered()
    },
})
lsp.on_attach(function(_, bufnr)
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
end)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true             -- enables snippet support
-- Next, you can provide targeted overrides for specific servers.
-- use that to configure your language servers

--------------------------- SERVERS
lsp.configure('lua_ls', {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- LuaJIT in the case of Neovim
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                --     -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            }
        }
    }
})
-------------------------
lsp.configure('gopls', {
    capabilities = capabilities,
    cmd = { "gopls", "serve" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
        },
        staticcheck = true,
    }
})
---------------------
lsp.configure('jdtls', {
    capabilities = capabilities,
    root_dir = require('lspconfig/util').root_pattern(".git", "pom.xml", "build.xml", "settings.gradle"),
})
lsp.configure('rust_analyzer', {
    capabilities = capabilities,
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
})

lsp.setup()             -- this should be the last thing
