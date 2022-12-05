-- for debugging, uncomment last line, try running the lsp and run :LSPLog
-- vim.lsp.set_log_level("debug")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local bufopts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
vim.keymap.set('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
vim.keymap.set('n', 'gt', "<cmd>lua vim.lsp.buf.type_definitions()<CR>", bufopts)
vim.keymap.set('n', '<leader>Q', "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
vim.keymap.set('n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)

vim.keymap.set('n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
vim.keymap.set('i', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)

vim.keymap.set('n', '<leader>R', "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
vim.keymap.set('n', '<leader>F', "<cmd>lua vim.lsp.buf.format()<CR>", bufopts)
vim.keymap.set('n', '<leader>A', "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)

vim.keymap.set('n', '<leader>d', "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
vim.keymap.set('n', '<leader>D', "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostics<cr>", bufopts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
          augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]]
    end
end

-- lspconfig + mason
local lspconfig = require('lspconfig')
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",
    },
    automatic_installation = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true -- enables snippet support

require("mason-lspconfig").setup_handlers({

    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,

    -- Next, you can provide targeted overrides for specific servers.
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup {
            capabilities = capabilities,
            on_attach = on_attach,
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
        }
    end,

    -- uncomment below if needed
    -------------------------
    ["gopls"] = function()
        lspconfig.gopls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "gopls", "serve" },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                },
                staticcheck = true,
            }
        }
    end,
    ---------------------
    ["jdtls"] = function()
        lspconfig.jdtls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = require('lspconfig/util').root_pattern(".git", "pom.xml", "build.xml", "settings.gradle"),
        }
    end,
    --------------------------
    ["clangd"] = function()
        lspconfig.clangd.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = require('lspconfig/util').root_pattern("compile_commands.json", "compile_flags.txt", ".git", "Makefile", "makefile"),
            filetypes = { "c", "cpp", "h", "hpp" }, -- we don't want objective-c and objective-cpp!?
            -- if does not work, use find . | grep clangd and do export PATH=$PATH:<clangd executable>
            cmd = { "clangd",
                "--background-index",
                "--suggest-missing-includes", "--clang-tidy" },
            single_file_support = true,
        }
    end,
    --------------------------
    ["rust_analyzer"] = function ()
       lspconfig.rust_analyzer.setup {
            cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            settings = {
                rust = {
                    unstable_features = true,
                    build_on_save = false,
                    all_features = true,
                },
            }
        }
    end,
})
