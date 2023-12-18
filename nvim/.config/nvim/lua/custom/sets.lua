----------  SETS
vim.cmd([[:set guicursor=n:block,i:block,v:block]])
vim.cmd([[ :set clipboard=unnamedplus ]])
vim.cmd([[ autocmd! VimEnter *.txt set wrap ]])
vim.cmd([[ autocmd! VimEnter *.wiki set wrap ]])
vim.opt.grepprg = "rg \\ --vimgrep"
vim.opt.updatetime = 50
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
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
vim.opt.winbar:append("%f")

-------------- PASSIVE MAPS
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'passive centering' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'passive centering' })
vim.keymap.set("n", "n", "nzz", { desc = 'passive centering' })
vim.keymap.set("n", "N", "Nzz", { desc = 'passive centering' })
vim.keymap.set("n", "Q", "<nop>", { desc = 'remove Q mapping' })
vim.keymap.set("n", "<leader>v", "<C-v>", { desc = 'enter visual-block mode' })
vim.keymap.set("n", "gv", "`[v`]", { desc = 'select last pasted text' })
vim.keymap.set("v", "<", "<gv", { desc = 'passive tab indent on visual mode' })
vim.keymap.set("v", ">", ">gv", { desc = 'passive tab indent on visual mode' })
