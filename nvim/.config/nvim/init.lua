vim.loader.enable()
P = function(v)
    print(vim.inspect(v))
    return v
end
-- prints the result of P(v) to the current buffer, if it's stringfiable
Pbuf = function(v)
    local bufnr = vim.fn.bufnr("")
    local lines = vim.split(P(v), "\n")
    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
end

local is_git_repo = function()
    local cwd = vim.fn.getcwd()
    local git_dir = vim.fn.expand(cwd .. '/.git')
    return vim.fn.isdirectory(git_dir) == 1
end
--" ============ACTIVE MAPS============
vim.keymap.set("n", "<Space>", "<nop>", { silent = true, desc = '' })
vim.keymap.set("x", "<Space>", "<nop>", { silent = true, desc = '' })
vim.keymap.set("n", "Q", "<nop>", { desc = 'remove Q mapping' })

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>a", "GVgg", { silent = true, desc = 'select all file' })
vim.keymap.set("n", "Y", "y$", { silent = true, desc = 'yank to the end' })
vim.keymap.set('x', '<leader>p', '"0p', { silent = true, desc = 'paste last yanked text without losing content' })
vim.keymap.set('x', '<leader>p', [["_dP]], { silent = true, desc = 'paste last yanked text without losing content' })
vim.keymap.set("n", "<leader>w", ":wa<CR>", { desc = 'save all files' })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = 'enter visual-block mode' })
vim.keymap.set("n", "gv", "`[v`]", { desc = 'select last pasted text' })

-- move lines up or down
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = 'move lines up' })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = 'move lines down' })
vim.keymap.set("n", "<M-j>", ":m+<cr>", { desc = 'move lines down' })
vim.keymap.set("n", "<M-k>", ":m-2<cr>", { desc = 'move lines up' })

vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = 'esc' })
vim.keymap.set("n", "<C-c>", "<ESC>", { silent = true, desc = 'esc' })

-- this is how i adapted with using bufferline, this way i can quickly manage opened buffers iterating between them and deleting the ones i don't want
vim.keymap.set("n", "<left>", ":bp<CR>", { desc = 'buffer prev' })
vim.keymap.set("n", "<right>", ":bn<CR>", { desc = 'buffer next' })
vim.keymap.set("n", "<down>", ":bd<CR>", { desc = 'buffer close' })
vim.keymap.set("n", "<up>", "<C-^>", { desc = 'buffer last' })
vim.keymap.set("n", "<leader>h", ":bp<CR>", { desc = 'buffer prev' })
vim.keymap.set("n", "<leader>l", ":bn<CR>", { desc = 'buffer next' })
vim.keymap.set("n", "<leader>m", ":bd<CR>", { desc = 'buffer close' })
vim.keymap.set("n", "<M-o>", "<C-^>", { desc = 'buffer last' })

vim.keymap.set("n", "<C-h>", ":cprev<CR>zz", { desc = 'quickfix list next' })
vim.keymap.set("n", "<C-l>", ":cnext<CR>zz", { desc = 'quickfix list prev' })
vim.keymap.set("n", "<C-q>", ":cclose<CR>zz", { desc = 'quickfix list close' })

vim.keymap.set("n", "<Leader><CR>", ":so<cr>", { desc = 'source current lua file' })
vim.keymap.set("n", "+", "<C-a>", { silent = true, desc = 'increment' })
vim.keymap.set("n", "-", "<C-x>", { silent = true, desc = 'decrement' })

----------  SETS
vim.cmd([[:set guicursor=n:block,i:block,v:block]])
vim.cmd([[ :set clipboard=unnamedplus ]])
vim.cmd([[ autocmd! VimEnter *.txt set wrap ]])
vim.cmd([[ autocmd! VimEnter *.md set wrap ]])
vim.opt.grepprg = "rg \\ --vimgrep"
vim.opt.updatetime = 100
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 999
vim.opt.modifiable = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shortmess:append("A")
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.g.airline_theme = "deus"
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.background = "dark"
vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]

-------------- PASSIVE MAPS
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'passive centering' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'passive centering' })
vim.keymap.set("n", "n", "nzz", { desc = 'passive centering' })
vim.keymap.set("n", "N", "Nzz", { desc = 'passive centering' })
vim.keymap.set("v", "<", "<gv", { desc = 'passive tab indent on visual mode' })
vim.keymap.set("v", ">", ">gv", { desc = 'passive tab indent on visual mode' })

-- PLUGINS
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { -- Colors and UI
        {
            'ellisonleao/gruvbox.nvim',
            config = function()
                vim.cmd.colorscheme("gruvbox")
            end,
        },
        {
            'akinsho/bufferline.nvim',
            version = "*",
            event = { 'BufReadPre', 'BufNewFile' },
            config = function()
                vim.opt.termguicolors = true
                require("bufferline").setup({
                    options = {
                        modified_icon = '+',
                        show_buffer_icons = false,
                        show_buffer_close_icons = false,
                        show_close_icon = false,
                        tab_size = 10,
                    },
                })
            end,
        },
        {
            'nvim-lualine/lualine.nvim',
            event = { 'BufReadPre', 'BufNewFile' },
            config = function()
                require('lualine').setup({
                    extensions = {},
                    inactive_sections = {
                        lualine_a = {},
                        lualine_b = {},
                        lualine_c = { "filename" },
                        lualine_x = { "location" },
                        lualine_y = {},
                        lualine_z = {}
                    },
                    inactive_winbar = {},
                    options = {
                        theme = "gruvbox",
                        icons_enabled = false,
                        component_separators = {
                            left = "",
                            right = ""
                        },
                        section_separators = {
                            left = "",
                            right = ""
                        },
                    },
                    sections = {
                        lualine_a = { "mode" },
                        lualine_b = { "branch", "diff", "diagnostics", },
                        lualine_c = { "filename" },
                        -- lualine_c = { "vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('%:p')), ':~:.')" }, -- seems like better filename resolving for wsl
                        lualine_x = { "encoding", },
                        lualine_y = { "progress" },
                        lualine_z = { "location" }
                    },
                    tabline = {},
                    winbar = {},
                })
            end,
        },
    },

    { -- Treesitter
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
        },
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })()
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    -- essential
                    "bash", "comment", "lua", "luadoc", "vim", "vimdoc", "diff", "gitcommit", "markdown", "markdown_inline", "xml", "yaml",
                    -- most used
                    "javascript", "typescript", "go", "c", "cpp", "python", "kotlin", "java", "html", "jsdoc", "rust", "sql", "tsx",
                },
                sync_install = false,
                auto_install = true, -- works since i will have treesitter cli installed
                indent = { enable = true },
                highlight = { enable = true, },
                textobjects = {
                    enable = true,
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']f'] = '@function.outer',
                            [']c'] = '@class.outer'
                        },
                        goto_previous_start = {
                            ['[f'] = '@function.outer',
                            ['[c'] = '@class.outer'
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ["<leader>sw"] = "@parameter.inner" },
                    }
                }
            }
        end,
    },



    { ----Telescope
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = 'Telescope',
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            local action_state = require("telescope.actions.state")
            local mymappings = {
                ['<esc>'] = actions.close, -- this ensures i don't have a normal mode meaning i only press esc once to close it
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<tab>'] = actions.toggle_selection,
                ['<cr>'] = function(pb) -- TODO: change this to file edit all when this issue is closed https://github.com/nvim-telescope/telescope.nvim/issues/416
                    local picker = action_state.get_current_picker(pb)
                    local multi = picker:get_multi_selection()
                    actions.select_default(pb) -- the normal enter behaviour
                    for _, j in pairs(multi) do
                        if j.path ~= nil then  -- is it a file -> open it as well:
                            vim.cmd(string.format("%s %s", "edit", j.path))
                        end
                    end
                end,
            }

            local picker_settings = {
                find_command = { "fd", "--strip-cwd-prefix", "--type", "f" },
                hidden = true,
            }
            telescope.setup {
                defaults = {
                    mappings = { i = mymappings, n = mymappings, },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim",
                        "--hidden",
                    },
                    file_ignore_patterns = {
                        "node_modules/",
                        "Session.vim",
                        ".git/",
                        "build/",
                        "target/",
                        ".idea/",
                        ".dart_tools/",
                    }
                },
                pickers = {
                    find_files = picker_settings,
                    git_files = picker_settings,
                },
            }
            local builtin = require('telescope.builtin')
            local function project_files()
                local ok = pcall(builtin.git_files)
                if not ok then builtin.find_files() end
            end
            vim.keymap.set('n', '<leader><leader>h', builtin.help_tags, { desc = '[H]elp' })
            vim.keymap.set("n", "<leader><leader>k", builtin.keymaps, { desc = 'telescope keymaps' })

            -- use this more, it's a good replacement for leaning harpoon, if used with :bp :bn and :bd
            vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = 'telescope buffers' })
            vim.keymap.set("n", "<leader><leader>o", builtin.oldfiles, { desc = 'find recently opened files' })

            vim.keymap.set("n", "<leader><leader>p", project_files, { desc = 'Project File Search' })
            vim.keymap.set("n", "<leader><leader>f", function()
                builtin.grep_string({
                    shorten_path = true,
                    search = '',
                }, { desc = 'Project String Search' })
            end)
        end,
    },

    { -- Editor (things I'll hardly modify)
        {
            'zegabr/toolbox.nvim',
            config = function()
                vim.keymap.set('n', '<leader><leader>%', ":CopyFilename<CR>",
                    { noremap = true, silent = true, desc = 'copy current file name to clipboard' })
                vim.keymap.set('n', '<leader>S', ":SearchReplaceSnippetFile<CR>",
                    { noremap = true, silent = true, desc = 'global replace snippet normal mode' })
                vim.keymap.set("x", "<leader>S", ":SearchReplaceSnippetRange<CR>",
                    { desc = 'global replace snippet visual mode' })
                vim.keymap.set("x", "<leader>m", ":MultiLineMacro ", { desc = 'run macro per line on visual mode' })
            end
        },
        {
            'mhinz/vim-signify',
            event = { 'BufReadPre', 'BufNewFile' },
            config = function()
                vim.keymap.set("n", "[h", "<plug>(signify-prev-hunk)", { desc = 'prev hunk' })
                vim.keymap.set("n", "]h", "<plug>(signify-next-hunk)", { desc = 'next hunk' })
            end,
        },
        {
            "AckslD/nvim-neoclip.lua",
            dependencies = { 'nvim-telescope/telescope.nvim' },
            config = function()
                require('neoclip').setup({
                    keys = {
                        telescope = {
                            i = {
                                paste_behind = '<cr>', -- paste on select, why not?
                                paste = '<c-p>',       -- this is pasting at end of line (TODO: test on linux)
                            },
                        },
                    },
                })
                vim.keymap.set("n", '"', require('telescope').extensions.neoclip.default, { desc = 'Telescope Neoclip' })
            end,
        },

        { 'ntpeters/vim-better-whitespace' }, --trim whitespace with :StripWhiteSpace

        { 'tpope/vim-obsession', },           --vim store session :Obsession TODO -> remember to add *Session.vim it to your .git/info/exclude (my 'vs' bash alias already does that for me)

        -- Comments
        { 'tpope/vim-commentary', }, -- <count>gcc | gcgc | visual gc

        -- Surround
        { 'tpope/vim-surround' }, ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
        -- simplest way to use it:
        -- TO ADD PAIR:
        -- 1) select with any visual mode.
        -- 2) press S<closing pair> or St<tagname>
        -- TO DELETE PAIR:
        -- 1) ds<surrounding pair>
        -- TO CHANGE PAIR:
        -- 1) cs<pair to be changed><new closing pair>
        {
            'stevearc/oil.nvim',
            config = function()
                require("oil").setup({
                    view_options = {
                        show_hidden = true,
                    },
                    delete_to_trash = true,
                    use_default_keymaps = true,
                    keymaps = {
                        ["g?"] = "actions.show_help",
                        ["<CR>"] = "actions.select",
                        ["<C-c>"] = "actions.close",
                        ["-"] = "actions.parent",
                        ["_"] = "actions.open_cwd",
                        ["g."] = "actions.toggle_hidden",
                    },
                })
                vim.keymap.set("n", "<Leader>e", ":Oil<CR>", { desc = "open file tree" })
            end
        },
        {
            "j-hui/fidget.nvim",
            tag = "v1.0.0",
            opts = {
                -- options
            },
        },

        -- color picker
        { "uga-rosa/ccc.nvim" },

        { -- this does not exists on other editors
            'mbbill/undotree',
            config = function()
                vim.cmd([[
            let g:undotree_WindowLayout = 2
            if has("persistent_undo")
                set undodir=$HOME."/.undodir"
                set undofile
            endif
        ]])
                vim.opt.swapfile = false
                vim.opt.backup = false
                vim.opt.undodir = os.getenv("HOME") .. "/.undodir"
                vim.opt.undofile = true
                -- toggle
                vim.keymap.set("n", "<leader><leader>u", vim.cmd.UndotreeToggle)

                --" undo break points
                vim.keymap.set("i", ",", ",<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
                vim.keymap.set("i", "?", "?<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
                vim.keymap.set("i", "!", "!<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
                vim.keymap.set("i", ".", ".<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
                vim.keymap.set("i", ";", ";<c-g>u", { silent = true, desc = 'passive undo breakpoint' })
            end,
        },
        {
            'gelguy/wilder.nvim',
            dependencies = { 'romgrk/fzy-lua-native' },
            keys = { ':', '/', '?', },
            build = ':UpdateRemotePlugins',
            init = function()
                vim.opt.wildignore = {
                    "*.pyc",
                    "*_build/*",
                    "**/coverage/*",
                    "**/node_modules/*",
                    "**/android/*",
                    "**/ios/*",
                    "**/.git/*",
                }
            end,
            config = function()
                local wilder = require('wilder')
                wilder.setup({ modes = { ':', '/', '?' } })
                -- Disable Python remote plugin
                wilder.set_option('use_python_remote_plugin', 0)

                wilder.set_option('pipeline', {
                    wilder.branch(
                        wilder.cmdline_pipeline({
                            fuzzy = 1,
                            fuzzy_filter = wilder.lua_fzy_filter(),
                        }),
                        wilder.vim_search_pipeline()
                    )
                })
                wilder.set_option('renderer', wilder.renderer_mux({
                    [':'] = wilder.popupmenu_renderer({
                        highlighter = wilder.lua_fzy_highlighter(),
                        right = {
                            ' ',
                            wilder.popupmenu_scrollbar()
                        },
                    }),
                    ['/'] = wilder.wildmenu_renderer({
                        highlighter = wilder.lua_fzy_highlighter(),
                    }),
                }))
            end
        },
    },


    { ----LSP (code editing)
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
            dependencies = {
                { "rafamadriz/friendly-snippets" },
                { 'saadparwaiz1/cmp_luasnip' },

            },
        },

        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },
                -- Snippets
                { "L3MON4D3/LuaSnip" },
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load() -- from luasnip
                local cmp = require('cmp')
                cmp.setup({
                    mapping = cmp.mapping.preset.insert({
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ['<esc>'] = cmp.mapping {
                            i = cmp.mapping.abort(),
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
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                fallback()
                            end
                        end),
                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                fallback()
                            end
                        end),
                    }),
                    sources = {
                        { name = 'path' },
                        { name = 'nvim_lsp', keyword_length = 1 },
                        { name = 'luasnip',  keyword_length = 2 }, -- from luasnip
                        { name = 'nvim_lua', keyword_length = 3 },
                        { name = 'buffer',   keyword_length = 3 },
                    },
                    snippet = {
                        expand = function(args)
                            require 'luasnip'.lsp_expand(args.body)
                        end
                    },
                })
            end
        },

        {
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
                { "folke/neodev.nvim",                opts = {} },
            },
            opts = function(_, opts)
                return vim.tbl_deep_extend("force", opts, {
                    servers = {
                        lua_ls = {
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
                        bashls = {
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            filetypes = { 'sh', '.bash_aliases', '.bashrc', '.bash_aliases_work', '.profile', '.bash_profile' },
                        },
                        gopls = {
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            settings = {
                                gopls = {
                                    analyses = {
                                        unusedparams = true,
                                    },
                                },
                                staticcheck = true,
                            },
                            extra_on_attach = function(bufnr)
                                vim.api.nvim_create_autocmd('BufWritePre', {
                                    buffer = bufnr,
                                    pattern = '*.go',
                                    callback = function()
                                        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
                                    end
                                })
                            end
                        },

                        eslint = {
                            capabilities = require('cmp_nvim_lsp').default_capabilities(),
                            extra_on_attach = function(bufnr)
                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
                                    command = "EslintFixAll",
                                })
                            end
                        },
                    },
                })
            end,
            config = function(_, opts)
                require("neodev").setup({})
                require("mason").setup()
                local mason_lspconfig = require('mason-lspconfig')
                mason_lspconfig.setup {
                    ensure_installed = {
                        'lua_ls',
                        'vimls',
                        'bashls',
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

                local lspconfig = require("lspconfig")
                for server_name, server_opts in pairs(opts.servers or {}) do
                    lspconfig[server_name].setup(server_opts)
                end
            end,
        },

        { -- annotation/comment doc generator -- USAGE: `:Neogen`
            "danymat/neogen",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "L3MON4D3/LuaSnip",
            },
            config = function()
                require("neogen").setup({
                    snippet_engine = "luasnip"
                })
            end,
            version = "*",
        },
    },


    { -- vimwiki
        'vimwiki/vimwiki',
        ft = 'markdown',
        init = function()
            -- this should run before load
            vim.g.vimwiki_map_prefix = '<Leader><Leader>v'
            vim.g.vimwiki_markdown_link_ext = 1
        end,
        config = function()
            vim.cmd([[
                set nocompatible
                filetype plugin on
                syntax on
                let g:vimwiki_list = [{'path': '~/notes/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                       \ 'links_space_char': '_'}]
            ]])
        end
    },


    -- { -- Http files-- see exmaples here https://github.com/rest-nvim/rest.nvim/tree/main/tests
    --     "rest-nvim/rest.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     ft = 'http',
    --     config = function()
    --         require("rest-nvim").setup({
    --             -- Open request results in a horizontal split
    --             result_split_horizontal = false,
    --             -- Keep the http file buffer above|left when split horizontal|vertical
    --             result_split_in_place = false,
    --             -- stay in current windows (.http file) or change to results window (default)
    --             stay_in_current_window_after_split = false,
    --             -- Skip SSL verification, useful for unknown certificates
    --             skip_ssl_verification = false,
    --             -- Encode URL before making request
    --             encode_url = true,
    --             -- Highlight request on run
    --             highlight = {
    --                 enabled = true,
    --                 timeout = 150,
    --             },
    --             result = {
    --                 -- toggle showing URL, HTTP info, headers at top the of result window
    --                 show_url = true,
    --                 -- show the generated curl command in case you want to launch
    --                 -- the same request via the terminal (can be verbose)
    --                 show_curl_command = false,
    --                 show_http_info = true,
    --                 show_headers = true,
    --                 -- table of curl `--write-out` variables or false if disabled
    --                 -- for more granular control see Statistics Spec
    --                 show_statistics = false,
    --                 -- executables or functions for formatting response body [optional]
    --                 -- set them to false if you want to disable them
    --                 formatters = {
    --                     json = "jq",
    --                     html = function(body)
    --                         return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
    --                     end
    --                 },
    --             },
    --             -- Jump to request line on run
    --             jump_to_request = false,
    --             env_file = '.env.http',
    --             custom_dynamic_variables = {},
    --             yank_dry_run = true,
    --             search_back = true,
    --         })

    --         vim.keymap.set("n", "<leader><leader>rr", "<Plug>RestNvim", { desc = 'run rest request in current line' })
    --         vim.keymap.set("n", "<leader><leader>rl", "<Plug>RestNvimLast",
    --             { desc = 'run last rest request in current line' })
    --         vim.keymap.set("n", "<leader><leader>rp", "<Plug>RestNvimPreview",
    --             { desc = 'preview rest request curl command' })
    --     end
    -- }


    {                               -- specific plugins to work with git, doesn't allow mercurial
        {
            'ruifm/gitlinker.nvim', -- get premalink by <leader>gy (works in visuali mode)
            keys = '<leader>gy',
            enabled = is_git_repo(),
            config = function()
                require("gitlinker").setup({
                    mappings = "<leader>gy",
                })
            end
        },

        {
            'f-person/git-blame.nvim',
            cmd = 'GitBlameToggle',
            enabled = is_git_repo(),
            config = function()
                require('gitblame').setup({ enabled = false, })
                -- :GitBlameToggle when needed
            end
        },

        {
            "kdheepak/lazygit.nvim",
            enabled = is_git_repo(),
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                vim.keymap.set("n", "<leader>G", ":LazyGit<CR>", { silent = true, desc = 'LazyGit toggle' })
            end
        },
    },

    -- {-- requires some cargo packages found on ../../../scripts/scripts/stuff/r.sh
    --     'lervag/vimtex',
    --     ft = 'tex',
    --     config = function()
    --         vim.g.vimtex_view_method = 'zathura'
    --         vim.g.vimtex_compiler_method = 'tectonic'
    --         vim.cmd([[
    --             let g:vimtex_compiler_tectonic = {
    --                 \ 'build_dir' : '',
    --                 \ 'hooks' : [],
    --                 \ 'options' : [
    --                 \   '--keep-logs',
    --                 \   '--synctex'
    --                 \ ],
    --                 \}
    --         ]])
    --     end
    -- },

    -- {
    --     'github/copilot.vim',
    --     event = 'InsertEnter',
    --     config = function()
    --         vim.keymap.set('i', '<C-y>', 'copilot#Accept("<CR>")', {
    --             expr = true,
    --             replace_keycodes = false
    --         })
    --         vim.g.copilot_no_tab_map = true
    --     end
    -- },
}

local opts = {}
require("lazy").setup(plugins, opts)
