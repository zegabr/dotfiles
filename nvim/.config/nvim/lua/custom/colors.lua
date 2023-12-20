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
                    -- lualine_c = { "filename" },
                    lualine_c = { "vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand('%:p')), ':~:.')" }, -- seems like better filename resolving for wsl
                    lualine_x = { "encoding", },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                tabline = {},
                winbar = {},
            })
        end,
    },
}
