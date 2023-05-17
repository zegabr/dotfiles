P = function(v)
    print(vim.inspect(v))
    return v
end

-- basic
require('zegabr.maps')
require('zegabr.sets')
require('zegabr.netrw')
require('zegabr.colors')

-- plugins
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
            require('zegabr.treesitter')
        end,
    }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    ----Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('zegabr.telescope')
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

            -- copilot
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require("copilot").setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end,
            },
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    -- TODO: make it not work for tex files
                    require("copilot_cmp").setup()
                end,
            },
        },
        config = function()
            require('zegabr.lsp')
        end,
    }

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

    ----Utilities
    use {
        'mbbill/undotree',
        config = function()
            require('zegabr.undotree') -- this does not exits in vscode u.u
        end,
    }
    use { 'ntpeters/vim-better-whitespace' } --trim whitespace with :StripWhiteSpace
    use { 'matze/vim-move' }                 --alt j/k moves selected lines normal and visual mode
    use { 'tpope/vim-obsession' }            --vim store session :Obsession
    use {
        'ruifm/gitlinker.nvim',              -- get premalink by <leader>gy (works in visuali mode)
        config = function() require("gitlinker").setup() end
    }

    use { 'romgrk/fzy-lua-native' }                                                                              --dependency for wilder
    use { 'gelguy/wilder.nvim', run = ':UpdateRemotePlugins', config = function() require('zegabr.wilder') end } --wilder menu

    use { 'tpope/vim-surround' }                                                                                 ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to use is:
    -- to add pair
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- to delete pair
    -- 1) ds<surrounding pair>
    -- to change pair
    -- 1) cs<pair to be changed><new closing pair>

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

    -- my first plugin
    -- use { 'zegabr/kokusen' }

    if packer_initializing then
        require('packer').sync()
    end
end)
