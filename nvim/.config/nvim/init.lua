P = function(v)
    print(vim.inspect(v))
    return v
end

--" ============ACTIVE MAPS============
vim.keymap.set("n", "<Space>", "<nop>", { desc = '' })
vim.keymap.set("v", "<Space>", "<nop>", { desc = '' })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>a", "GVgg", { desc = 'select all file' })
vim.keymap.set("n", "Y", "y$", { desc = 'select to the end' })
vim.keymap.set('v', '<leader>p', '"0p', { desc = 'paste last yanked text without losing content' })
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'paste last yanked text without losing content' })
vim.keymap.set("i", "jk", "<ESC>", { desc = 'esc' })
vim.keymap.set("n", "<C-c>", "<ESC>", { desc = 'esc' })
vim.keymap.set("n", "<leader>S", ":%s//gIc<Left><Left><Left><Left>", { desc = 'replace snippet normal mode' })
vim.keymap.set("x", "<leader>S", ":s//gIc<Left><Left><Left><Left>", { desc = 'replace snippet visual mode' })
vim.keymap.set("n", "<left>", ":bp<CR>", { desc = 'buffer prev' })
vim.keymap.set("n", "<right>", ":bn<CR>", { desc = 'buffer next' })
vim.keymap.set("n", "<down>", ":bd<CR>", { desc = 'buffer close' })
vim.keymap.set("n", "<up>", "<C-^>", { desc = 'buffer last' })
vim.keymap.set("n", "<C-h>", ":cprev<CR>zz", { desc = 'quickfix list next' })
vim.keymap.set("n", "<C-l>", ":cnext<CR>zz", { desc = 'quickfix list prev' })
vim.keymap.set("n", "<C-q>", ":cclose<CR>zz", { desc = 'quickfix list close' })
vim.keymap.set("n", "<Leader><CR>", ":so<cr>", { desc = 'source current lua file' })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = 'save file' })
vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile", { desc = 'test lua file' })
vim.keymap.set('n', '<leader><leader>%', [[:let @+ = fnamemodify(resolve(expand('%:p')), ':~:.')<CR>]],
    { noremap = true, silent = true, desc = 'copy current file name to clipboard' })
--" ============ PASSIVE MAPS============
vim.keymap.set("n", "<C-j>", "<C-d>zz", { desc = 'passive centering' })
vim.keymap.set("n", "<C-k>", "<C-u>zz", { desc = 'passive centering' })
vim.keymap.set("n", "n", "nzz", { desc = 'passive centering' })
vim.keymap.set("n", "N", "Nzz", { desc = 'passive centering' })
vim.keymap.set("n", "Q", "<nop>", { desc = 'remove Q mapping' })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = 'enter visual-block mode' })
vim.keymap.set("v", "<", "<gv", { desc = 'passive tabbing on visual mode' })
vim.keymap.set("v", ">", ">gv", { desc = 'passive tabbing on visual mode' })
vim.cmd([[
set clipboard=unnamedplus
augroup AUTOSAVE
  au!
  autocmd! InsertLeave,TextChanged,FocusLost * silent! update
augroup END
" wrap text when in a txt file
autocmd! VimEnter *.txt set wrap
]])

----------  SETS
local set = vim.opt
set.grepprg = "rg \\ --vimgrep"
set.updatetime = 50
-- set.guicursor = ""
vim.cmd [[:set guicursor=n:block,i:block,v:block]]
set.showmatch = true
set.splitright = true
set.splitbelow = true
set.scrolloff = 8
set.modifiable = true
set.number = true
set.relativenumber = true
set.wrap = false
set.cursorline = true
set.hlsearch = false
set.ignorecase = true
set.smartcase = true
set.shortmess:append("A")
set.softtabstop = 4
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.autoindent = true
set.winbar:append("%f")
-- TODO: add fold method
set.wildignore = {
    "*.pyc",
    "*_build/*",
    "**/coverage/*",
    "**/node_modules/*",
    "**/android/*",
    "**/ios/*",
    "**/.git/*",
}

---- NETRW
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)
-- - create file near current file: use %
-- - move file or folder : just press R to rename it
--
-- define an enumeration of supported operations
local NetrwOperations = {
    DELETE = "delete",
    COPY = "copy",
}

local function netrw_file_or_folder_operation(op)
    -- get the current directory or file in netrw
    local line = vim.api.nvim_get_current_line()
    local curdir = vim.api.nvim_buf_get_var(0, "netrw_curdir")
    -- construct the full path to the file or folder
    local path = string.format("%s/%s", curdir, line)
    -- create the command to perform the specified operation
    local command
    if op == NetrwOperations.DELETE then
        command = string.format("!rm -rf %s", path)
    elseif op == NetrwOperations.COPY then
        local newpath = string.sub(path, 1, string.len(path))
        command = string.format("!cp -r %s %s.copy", path, newpath)
    end
    -- run the command using the neovim API
    vim.api.nvim_command(command)
    vim.api.nvim_command(":file!")
end
function Netrw_delete_folder_or_file()
    netrw_file_or_folder_operation(NetrwOperations.DELETE)
end

function Netrw_copy_folder_or_file()
    netrw_file_or_folder_operation(NetrwOperations.COPY)
end

vim.cmd([[
"-- - delete folder: put cursor at file or folder
autocmd Filetype netrw nmap <buffer> <leader>D :lua Netrw_delete_folder_or_file()<CR>-<CR>
"-- - copy folder to other place: press <leader>C
autocmd Filetype netrw nmap <buffer> <leader>C :lua Netrw_copy_folder_or_file()<CR>-<CR>
]])

-- COLORS
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

-- PLUGINS
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_initializing = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_initializing = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end
return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' } -- Package manager

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })()
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = 'nvim-treesitter/nvim-treesitter',
        after = { 'nvim-treesitter' },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "bash",
                    "cpp",
                    "dockerfile",
                    "gitignore",
                    "go",
                    "html",
                    "java",
                    -- "latex",
                    "lua",
                    "markdown",
                    "python",
                    "rust",
                    "sql",
                    "typescript",
                    "vim",
                    "yaml",
                },
                sync_install = false,
                auto_install = true,
                indent = {
                    enable = true
                },
                highlight = {
                    enable = true,
                },
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
    }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    ----Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
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
                        ".git/",
                        "build/",
                        ".idea/",
                        ".dart_tools/",
                    }
                },
                pickers = {
                    find_files = {
                        find_command = { "fd", "--strip-cwd-prefix", "--type", "f" },
                        hidden = true,
                    },
                    git_files = {
                        find_command = { "fd", "--strip-cwd-prefix", "--type", "f" },
                        hidden = true,
                    },
                },
            }
            local builtin = require('telescope.builtin')
            local function project_files()
                local ok = pcall(builtin.git_files)
                if not ok then builtin.find_files() end
            end
            vim.keymap.set('n', '<leader><leader>h', builtin.help_tags, { desc = '[H]elp' })
            vim.keymap.set("n", "<leader><leader>k", builtin.keymaps, { desc = 'telescope keymaps' })
            vim.keymap.set("n", "<leader>glo", builtin.git_commits, { desc = 'git log' })
            vim.keymap.set("n", "<leader>glof", builtin.git_bcommits, { desc = 'git log current file' })
            vim.keymap.set("n", "<leader><leader>b", builtin.buffers, { desc = 'telescope buffers' })
            vim.keymap.set("n", "<leader><leader>p", project_files, { desc = 'Project File Search' })
            vim.keymap.set("n", "<leader><leader>f", function()
                builtin.grep_string({
                    shorten_path = true,
                    word_match = "-w",
                    only_sort_text = true,
                    search = '',
                }, { desc = 'Project String Search' })
            end)
        end,
    }

    ----LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        after = { 'telescope.nvim' },
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'nvim-telescope/telescope.nvim' }, -- important since zegabr.lsp uses telescope
        },
        config = function()
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
            capabilities.textDocument.completion.completionItem.snippetSupport = true -- enables snippet support
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

            lsp.setup() -- this should be the last thing
        end,
    }

    ----Utilities
    use {
        'mbbill/undotree',
        config = function()
            -- this does not exits in vscode u.u
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
            vim.keymap.set("i", ",", ",<c-g>u", { desc = 'passive undo breakpoint' })
            vim.keymap.set("i", "?", "?<c-g>u", { desc = 'passive undo breakpoint' })
            vim.keymap.set("i", "!", "!<c-g>u", { desc = 'passive undo breakpoint' })
            vim.keymap.set("i", ".", ".<c-g>u", { desc = 'passive undo breakpoint' })
            vim.keymap.set("i", ";", ";<c-g>u", { desc = 'passive undo breakpoint' })
        end,
    }
    use { 'ntpeters/vim-better-whitespace' } --trim whitespace with :StripWhiteSpace
    use { 'matze/vim-move' }                 --alt j/k moves selected lines normal and visual mode
    use { 'tpope/vim-obsession' }            --vim store session :Obsession
    use {
        'ruifm/gitlinker.nvim',              -- get premalink by <leader>gy (works in visuali mode)
        config = function() require("gitlinker").setup() end
    }

    use { 'romgrk/fzy-lua-native' } --dependency for wilder
    use { 'gelguy/wilder.nvim', run = ':UpdateRemotePlugins', config = function()
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
    end }
    use { 'tpope/vim-surround' } ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to use is:
    -- to add pair
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- to delete pair
    -- 1) ds<surrounding pair>
    -- to change pair
    -- 1) cs<pair to be changed><new closing pair>

    -- VCS integration
    use {
        'mhinz/vim-signify',
        config = function()
            vim.keymap.set("n", "[h", "<plug>(signify-prev-hunk)", { desc = 'prev hunk' })
            vim.keymap.set("n", "]h", "<plug>(signify-next-hunk)", { desc = 'next hunk' })
        end,
    }
    -- Comments
    use { 'tpope/vim-commentary' } -- gcc gcgc visual gc

    -- for latex
    -- use { 'lervag/vimtex',
    --     config = function()
    --         vim.cmd([[syntax enable]])
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
    --     end }

    -- Colors and UI
    use {
        'RRethy/nvim-base16',
        config = function()
            vim.cmd.colorscheme("base16-gruvbox-material-dark-hard")
            -- vim.cmd.colorscheme("base16-tokyo-city-dark")
        end,
    }
    use {
        'kdheepak/tabline.nvim',
        config = function()
            require('tabline').setup {
                enable = true,
                options = {
                    show_devicons = false,
                    show_filename_only = false, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ",       -- change the default modified icon
                    modified_italic = false,    -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = false,     -- this shows only tabs instead of tabs + buffers
                }
            }
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = { theme = 'gruvbox' },
            })
        end,
    }
    if packer_initializing then
        require('packer').sync()
    end
end)
