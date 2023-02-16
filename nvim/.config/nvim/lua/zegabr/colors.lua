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
