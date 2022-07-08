local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_initializing = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_initializing = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    use('wbthomason/packer.nvim') -- Package manager

    ----Telescope
    use("BurntSushi/ripgrep")
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")
    use("AckslD/nvim-neoclip.lua")

    ----Git integration
    use('tpope/vim-fugitive')
    use('airblade/vim-gitgutter')

    ----Comments
    use('tpope/vim-commentary') -- gcc gcgc visual gc

    ----Colors and UI
    use('ellisonleao/gruvbox.nvim')
    use('kdheepak/tabline.nvim')
    use('nvim-lualine/lualine.nvim')

    ----Utilities
    use('mbbill/undotree')
    use('ntpeters/vim-better-whitespace') --trim whitespace with :StripWhiteSpace
    use('bronson/vim-visual-star-search')
    use('matze/vim-move') --alt j/k moves selected lines normal and visual mode
    use('tpope/vim-obsession') --vim store session
    use {
        'ruifm/gitlinker.nvim', -- get premalink by <leader>gy (works in visuali mode)
        config = function() require("gitlinker").setup() end
    }

    use('romgrk/fzy-lua-native') --dependency for wilder
    use('gelguy/wilder.nvim', { run = ':UpdateRemotePlugins' }) --wilder menu

    use('tpope/vim-surround') ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to use is:
    -- to add pair
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- to delete pair
    -- 1) ds<surrounding pair>
    -- to change pair
    -- 1) cs<pair to be changed><new closing pair>

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/nvim-treesitter-textobjects')
    use('nvim-treesitter/nvim-treesitter-context')

    ----LSP
    use('neovim/nvim-lspconfig') --lsp configuration
    use('hrsh7th/cmp-nvim-lsp') --dependency for nvim-cmp
    use("hrsh7th/cmp-buffer")
    use('hrsh7th/nvim-cmp') --autocompletion
    use('hrsh7th/cmp-path') --path suggestions
    use('hrsh7th/cmp-nvim-lua') --lua suggestions

    use('L3MON4D3/LuaSnip') --lua snippets
    use('saadparwaiz1/cmp_luasnip') --luasnip src
    use('RRethy/vim-illuminate') --vim iluminate
    use('williamboman/nvim-lsp-installer') --lspinstaller
    use {
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        config = function()
            require("fidget").setup {}
        end,
    }
    ----nvim tree
    use('kyazdani42/nvim-web-devicons') --for file icons
    use('kyazdani42/nvim-tree.lua')
    use('/home/ze/Desktop/kokusen')

    if packer_initializing then
        require('packer').sync()
    end
end)
