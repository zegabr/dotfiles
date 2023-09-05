require('custom.debug')
require('custom.maps')
require('custom.sets')
require('custom.netrw')
require('custom.colors')

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
            require('custom.treesitter')
        end,
    }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    ----Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('custom.telescope')
        end,
    }

    ----LSP
    use {
        'neovim/nvim-lspconfig',
        after = { 'telescope.nvim' },
        requires = {
            -- LSP Support
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- { 'folke/neodev.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp' },
            -- { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            require('custom.lsp')
        end,
    }

    ----Utilities
    use {
        'mbbill/undotree',
        config = function()
            -- this does not exits in vscode u.u
            require('custom.undotree')
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
        require('custom.wilder')
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

    -- VCS integration (better than git signs)
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
    --         require('custom.latex')
    --     end
    -- }

    use { 'vimwiki/vimwiki',
        config = function()
            vim.cmd([[
                set nocompatible
                filetype plugin on
                syntax on
                let g:vimwiki_list = [{'path': '~/notes/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
            ]])
        end
    }

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
                    show_filename_only = true, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ",      -- change the default modified icon
                    modified_italic = false,   -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = false,    -- this shows only tabs instead of tabs + buffers
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
