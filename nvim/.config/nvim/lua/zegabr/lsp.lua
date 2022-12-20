local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'sumneko_lua',
    'vimls',
})

lsp.set_preferences({
    -- comment this if you want to show diagnostics icons
    sign_icons = {},
    -- setting this to false so it shows the message inline
    configure_diagnostics = false,
    set_lsp_keymaps = false,
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
lsp.setup_nvim_cmp({
    mapping = lsp.defaults.cmp_mappings({
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

})

lsp.on_attach(function(_, bufnr)
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- enables snippet support
-- Next, you can provide targeted overrides for specific servers.
-- use that to configure your big tech language servers
lsp.configure('sumneko_lua', {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- LuaJIT in the case of Neovim
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            -- workspace = {
            --     -- Make the server aware of Neovim runtime files
            --     library = vim.api.nvim_get_runtime_file("", true),
            -- },
            telemetry = {
                enable = false,
            }
        }
    }
})
-------------------------
-- lsp.configure('gopls', {
--     capabilities = capabilities,
--     cmd = { "gopls", "serve" },
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--             },
--         },
--         staticcheck = true,
--     }
-- })
---------------------
-- lsp.configure('jdtls', {
--     capabilities = capabilities,
--     root_dir = require('lspconfig/util').root_pattern(".git", "pom.xml", "build.xml", "settings.gradle"),
-- })
--------------------------
-- lsp.configure('clangd', {
--     capabilities = capabilities,
--     root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git",
--         "Makefile", "makefile"),
--     filetypes = { "c", "cpp", "h", "hpp" }, -- we don't want objective-c and objective-cpp!?
--     -- if does not work, use find . | grep clangd and do export PATH=$PATH:<clangd executable>
--     cmd = { "clangd",
--         "--background-index",
--         "--suggest-missing-includes", "--clang-tidy" },
--     single_file_support = true,
-- })
--------------------------
-- lsp.configure('rust_analyzer', {
--     capabilities = capabilities,
--     cmd = { "rustup", "run", "stable", "rust-analyzer" },
--     settings = {
--         rust = {
--             unstable_features = true,
--             build_on_save = false,
--             all_features = true,
--         },
--     }
-- })

lsp.setup() -- this should be the last thing
