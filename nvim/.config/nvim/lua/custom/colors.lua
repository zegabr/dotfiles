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


return { -- for lazy
    {
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
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
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'gruvbox',
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
            })
        end,
    },
}
