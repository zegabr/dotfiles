local util = require('lspconfig/util')

-- for debugging, uncomment last line, try running the lsp and run :LSPLog
-- vim.lsp.set_log_level("debug")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>R', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>A', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostics<cr>", bufopts)

    -- set illuminate
    require('illuminate').on_attach(client)
end

-- Configure lua language server for neovim development
local lua_settings = {
    Lua = {
        runtime = {
            -- LuaJIT in the case of Neovim
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
            enable = false,
        }
    }
}

-- go setup variables
local go_settings = {
    gopls = {
        analyses = {
            unusedparams = true,
        },
    },
    staticcheck = true,
}

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
    }
end

-- lsp installer
local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require('lspconfig')
lsp_installer.setup({})

for _, server in ipairs(lsp_installer.get_installed_servers()) do
    local config = make_config()
    local server_name = server.name

    -- language specific config (server == "<name passed on lspinstall call>")
    if server_name == "sumneko_lua" then
        config.settings = lua_settings
    end
    if server_name == "jdtls" then
        config.root_dir = util.root_pattern(".git", "pom.xml", "build.xml", "settings.gradle");
    end
    if server_name == "clangd" then
        config.root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", "Makefile", "makefile");
        config.filetypes = {"c", "cpp", "h", "hpp"}; -- we don't want objective-c and objective-cpp!?
        config.cmd = { "/home/ze/.local/share/nvim/lsp_servers/clangd/clangd", "--background-index", "--suggest-missing-includes", "--clang-tidy" };
        config.single_file_support = true;
    end
    if server_name == "gopls" then
        config.cmd = {"gopls", "serve"};
        config.settings = go_settings;
    end

    lspconfig[server_name].setup(config)
end
