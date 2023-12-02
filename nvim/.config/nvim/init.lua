require('custom.debug')
require('custom.maps')
require('custom.sets')
require('custom.netrw')
require('custom.colors')

-- TODO: look for lazivim
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
    { 'wbthomason/packer.nvim' }, -- Package manager

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({ with_sync = true })()
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        after = { 'nvim-treesitter' },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('custom.treesitter')
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-context' },

    ----Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('custom.telescope')
        end,
    },

    ----LSP
    {
        'neovim/nvim-lspconfig',
        after = { 'telescope.nvim' },
        dependencies = {
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
    },

    ----Utilities
    {
        'mbbill/undotree',
        config = function()
            -- this does not exits in vscode u.u
            require('custom.undotree')
        end,
    },
    { 'ntpeters/vim-better-whitespace' }, --trim whitespace with :StripWhiteSpace
    { 'matze/vim-move' },                 --alt j/k moves selected lines normal and visual mode
    { 'tpope/vim-obsession' },            --vim store session :Obsession TODO -> remember to add *Session.vim it to your .git/info/exclude
    {
        'ruifm/gitlinker.nvim',           -- get premalink by <leader>gy (works in visuali mode)
        config = function() require("gitlinker").setup() end
    },

    { 'romgrk/fzy-lua-native' }, --dependency for wilder
    {
        'gelguy/wilder.nvim',
        run = ':UpdateRemotePlugins',
        config = function()
            require('custom.wilder')
        end
    },
    { 'tpope/vim-surround' }, ---> https://www.youtube.com/watch?v=NsHAG4GmZYQ&list=WL&index=19
    -- simplest way to  i,s:
    -- to add pair
    -- 1) select with any visual mode.
    -- 2) press S<closing pair> or St<tagname>
    -- to delete pair
    -- 1) ds<surrounding pair>
    -- to change pair
    -- 1) cs<pair to be changed><new closing pair>

    -- VCS integration (better than git signs)
    {
        'mhinz/vim-signify',
        config = function()
            vim.keymap.set("n", "[h", "<plug>(signify-prev-hunk)", { desc = 'prev hunk' })
            vim.keymap.set("n", "]h", "<plug>(signify-next-hunk)", { desc = 'next hunk' })
        end,
    },

    -- Comments based on tpop plugin
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end
    }, -- gcc | gcgc | visual gc | gcip | dic

    -- for latex
    --  { 'lervag/vimtex',
    --     config = function()
    --         require('custom.latex')
    --     end
    -- },

    {
        'vimwiki/vimwiki',
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

    -- Colors and UI
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    },

    {
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
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = { theme = 'gruvbox' },
            })
        end,
    },
    {
        'David-Kunz/gen.nvim',
        config = function()
            -- require('gen').model = 'codellama' # default = 'mistral:instruct'
        end,
    },
}

local opts = {


}
require("lazy").setup(plugins, opts)
