local set = vim.opt
set.grepprg = "rg \\ --vimgrep"
set.updatetime = 50
-- set.guicursor = ""
vim.cmd[[:set guicursor=n:block,i:block,v:block]]
set.showmatch = true
set.splitright = true
set.splitbelow = true
set.scrolloff = 8
set.modifiable = true
set.number = true
set.relativenumber = true
set.wrap = false
set.cursorline = true
set.hlsearch = false
set.ignorecase = true
set.smartcase = true
set.shortmess:append("A")
set.softtabstop = 4
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.autoindent = true
set.winbar:append("%f")

-- Ignore files
set.wildignore = {
    "*.pyc",
    "*_build/*",
    "**/coverage/*",
    "**/node_modules/*",
    "**/android/*",
    "**/ios/*",
    "**/.git/*",
}
