-- Colors and UI
vim.pack.add({
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
})

vim.cmd.colorscheme("gruvbox")

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
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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
