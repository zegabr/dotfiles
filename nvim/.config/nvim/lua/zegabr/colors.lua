vim.opt.termguicolors = true
vim.opt.showmode = false
vim.g.airline_theme="deus"
vim.opt.background="dark"
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

require("gruvbox").setup({ -- must be called before colorshceme gruvbox
  undercurl = true,
  underline = true,
  bold = true,
  italic = false, -- will make italic comments and special strings
  inverse = true, -- invert background for search, diffs, statuslines and errors
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  contrast = "", -- can be "hard" or "soft"
  overrides = {},
})
vim.cmd[[ colorscheme gruvbox ]]

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
