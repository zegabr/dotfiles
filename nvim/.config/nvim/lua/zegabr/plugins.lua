local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_initializing = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_initializing = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' } -- Package manager

    ----Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    ----VCS integration
    use { 'mhinz/vim-signify' }

    ----Comments
    use { 'tpope/vim-commentary' } -- gcc gcgc visual gc

    ----Colors and UI
    use { "RRethy/nvim-base16" }
    use { 'kdheepak/tabline.nvim' }
    use { 'nvim-lualine/lualine.nvim' }

    ----Utilities
    use { 'mbbill/undotree' }
    use { 'ntpeters/vim-better-whitespace' } --trim whitespace with :StripWhiteSpace
    use { 'matze/vim-move' } --alt j/k moves selected lines normal and visual mode

    use { 'tpope/vim-obsession' } --vim store session
    use {
        'ruifm/gitlinker.nvim', -- get premalink by <leader>gy (works in visuali mode)
        config = function() require("gitlinker").setup() end
    }

    use { 'romgrk/fzy-lua-native' } --dependency for wilder
    use { 'gelguy/wilder.nvim', run = ':UpdateRemotePlugins', config = function() require('zegabr.wilder') end } --wilder menu


    use { 'tpope/vim-surround' } ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to use is:
    -- to add pair
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- to delete pair
    -- 1) ds<surrounding pair>
    -- to change pair
    -- 1) cs<pair to be changed><new closing pair>

    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    ----LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
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
        }
    }

    use { 'github/copilot.vim' }

    -- my first plugin
    use { 'zegabr/kokusen' }

    if packer_initializing then
        require('packer').sync()
    end
end)
