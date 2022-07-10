vim.opt.termguicolors = true
vim.opt.showmode = false
vim.g.airline_theme="deus"
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.background="dark"
vim.cmd[[ colorscheme base16-gruvbox-dark-hard ]]

require('lualine').setup({
    options = { theme = 'gruvbox' },
})

require('tabline').setup {
    enable = true,
    options = {
        show_filename_only = false, -- shows base filename only instead of relative path in filename
        modified_icon = "+ ", -- change the default modified icon
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
    }
}
vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
