
require('symbols-outline').setup {
    -- whether to highlight the currently hovered symbol
    -- disable if your cpu usage is higher than you want it
    -- or you just hate the highlight
    -- default: true
    highlight_hovered_item = true,

    -- whether to show outline guides
    -- default: true
    show_guides = true,
}

-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<esc>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
        { name = 'nvim_lua' },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        with_text = true,
        menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
        },
    },
    --experimental = {
        --native_menu = false,
    --}
})

--========== LSP CONFIG ==========
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- vim
-- npm install -g vim-language-server
require'lspconfig'.vimls.setup{}

-- lua
-- see github.com/zegabr/m -> v.sh  (see how I install lua language server inside ~/nvim-deps)
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

local sumneko_root_path = '/home/ze/nvim-deps/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- python
-- npm i -g pyright
require'lspconfig'.pyright.setup{}

-- bash
-- npm i -g bash-language-server
require'lspconfig'.bashls.setup{
    filetypes = { "sh", "zsh", "bashrc","zshrc", "bash_aliases", "bash_aliases_work" },
}

-- typescript
-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{}

-- C++
-- sudo apt-get install clangd-12
-- sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
require'lspconfig'.clangd.setup {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    filetypes = { "c", "cpp", "h"}
}

-- docker
-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup{}

-- go
--require'lspconfig'.gopls.setup(config({
--cmd = {"gopls", "serve"},
--settings = {
--gopls = {
--analyses = {
--unusedparams = true,
--},
--staticcheck = true,
--},
--},
--}))
