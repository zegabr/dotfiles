local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'sumneko_lua',
    'vimls',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    ['<esc>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping(
        cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        { "i", "c" }
    ),
})

lsp.set_preferences({
    -- comment this if you want to show diagnostics icons
    sign_icons = {},
    -- setting this to false so it shows the message inline
    configure_diagnostics = false,
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local bufopts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, bufopts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, bufopts)
    vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definitions() end, bufopts)
    vim.keymap.set('n', '<leader>Q', function() vim.diagnostic.setloclist() end, bufopts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, bufopts)

    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, bufopts)
    vim.keymap.set('i', '<C-k>', function() vim.lsp.buf.signature_help() end, bufopts)

    vim.keymap.set('n', '<leader>R', function() vim.lsp.buf.rename() end, bufopts)
    vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format() end, bufopts)
    vim.keymap.set('n', '<leader>A', function() vim.lsp.buf.code_action() end, bufopts)

    vim.keymap.set('n', '<leader>d', function() vim.diagnostic.goto_next() end, bufopts)
    vim.keymap.set('n', '<leader>D', function() vim.diagnostic.open_float() end, bufopts)
    vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostics<cr>", bufopts)
end)

lsp.setup()

-- TODO: use this as references setup local language servers like the one in your big company job
-- require("mason-lspconfig").setup_handlers({

--    -- The first entry (without a key) will be the default handler
--    -- and will be called for each installed server that doesn't have
--    -- a dedicated handler.
--    function(server_name) -- default handler (optional)
--        require("lspconfig")[server_name].setup {}
--    end,

--    -- Next, you can provide targeted overrides for specific servers.
--    ["sumneko_lua"] = function()
--        lspconfig.sumneko_lua.setup {
--            capabilities = capabilities,
--            on_attach = on_attach,
--            settings = {
--                Lua = {
--                    runtime = {
--                        -- LuaJIT in the case of Neovim
--                        version = 'LuaJIT',
--                        path = vim.split(package.path, ';'),
--                    },
--                    diagnostics = {
--                        -- Get the language server to recognize the `vim` global
--                        globals = { 'vim' },
--                    },
--                    -- workspace = {
--                    --     -- Make the server aware of Neovim runtime files
--                    --     library = vim.api.nvim_get_runtime_file("", true),
--                    -- },
--                    telemetry = {
--                        enable = false,
--                    }
--                }
--            }
--        }
--    end,
--    -------------------------
--    ["gopls"] = function()
--        lspconfig.gopls.setup {
--            capabilities = capabilities,
--            on_attach = on_attach,
--            cmd = { "gopls", "serve" },
--            settings = {
--                gopls = {
--                    analyses = {
--                        unusedparams = true,
--                    },
--                },
--                staticcheck = true,
--            }
--        }
--    end,
--    ---------------------
--    ["jdtls"] = function()
--        lspconfig.jdtls.setup {
--            capabilities = capabilities,
--            on_attach = on_attach,
--            root_dir = require('lspconfig/util').root_pattern(".git", "pom.xml", "build.xml", "settings.gradle"),
--        }
--    end,
--    --------------------------
--    ["clangd"] = function()
--        lspconfig.clangd.setup {
--            capabilities = capabilities,
--            on_attach = on_attach,
--            root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git", "Makefile", "makefile"),
--            filetypes = { "c", "cpp", "h", "hpp" }, -- we don't want objective-c and objective-cpp!?
--            -- if does not work, use find . | grep clangd and do export PATH=$PATH:<clangd executable>
--            cmd = { "clangd",
--                "--background-index",
--                "--suggest-missing-includes", "--clang-tidy" },
--            single_file_support = true,
--        }
--    end,
--    --------------------------
--    ["rust_analyzer"] = function ()
--       lspconfig.rust_analyzer.setup {
--            cmd = { "rustup", "run", "stable", "rust-analyzer" },
--            settings = {
--                rust = {
--                    unstable_features = true,
--                    build_on_save = false,
--                    all_features = true,
--                },
--            }
--        }
--    end,
-- })
