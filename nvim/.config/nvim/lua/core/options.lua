
----------  SETS
vim.cmd([[:set guicursor=n:block,i:block,v:block]])
vim.cmd([[ :set clipboard=unnamedplus ]])
vim.cmd([[ autocmd! VimEnter *.txt set wrap ]])
vim.cmd([[ autocmd! VimEnter *.md set wrap ]])
vim.opt.grepprg = "rg \\ --vimgrep"
vim.opt.updatetime = 100
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 999
vim.opt.modifiable = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shortmess:append("A")
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.g.airline_theme = "deus"
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.background = "dark"
vim.g.jumpoptions = "stack"
vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
