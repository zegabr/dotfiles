--TODO: add packer if it is easy to install else go here https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    use('wbthomason/packer.nvim') -- Package manager

    ----Telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    ----Git integration
    use('tpope/vim-fugitive')
    use('airblade/vim-gitgutter')
    use('junegunn/gv.vim') --commit browser

    ----Comments
    use('tpope/vim-commentary')

    ----Colors and UI
    use('gruvbox-community/gruvbox')
    use('kdheepak/tabline.nvim')
    use('nvim-lualine/lualine.nvim')

    ----Utilities
    use('mbbill/undotree')
    use('ntpeters/vim-better-whitespace') --trim whitespace with :StripWhiteSpace
    use('bronson/vim-visual-star-search')
    use('matze/vim-move') --alt j/k moves selected lines normal and visual mode
    use('svermeulen/vim-yoink') --yank history
    use('tpope/vim-obsession') --vim store session

    use('romgrk/fzy-lua-native') --dependency for wilder
    use('gelguy/wilder.nvim', { run = ':UpdateRemotePlugins' }) --wilder menu

    use('tpope/vim-surround') ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19

    ----LSP
    use('neovim/nvim-lspconfig') --lsp configuration
    use('hrsh7th/cmp-nvim-lsp') --dependency for nvim-cmp
    use('hrsh7th/nvim-cmp') --autocompletion
    use('hrsh7th/cmp-path') --path suggestions
    use('hrsh7th/cmp-nvim-lua') --lua suggestions
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('L3MON4D3/LuaSnip') --lua snippets
    use('saadparwaiz1/cmp_luasnip') --luasnip src
    use('RRethy/vim-illuminate') --vim iluminate
    use('williamboman/nvim-lsp-installer') --lspinstaller

    ----nvim tree
    use('kyazdani42/nvim-web-devicons') --for file icons
    use('kyazdani42/nvim-tree.lua')
    if packer_bootstrap then
        require('packer').sync()
    end
end)
