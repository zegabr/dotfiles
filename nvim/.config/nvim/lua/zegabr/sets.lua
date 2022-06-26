local set = vim.opt
set.grepprg = "rg \\ --vimgrep"
set.updatetime = 100
set.guicursor = ""
set.showmatch = true
set.splitright = true
set.splitbelow = true
set.title = true
set.scrolloff = 8
set.modifiable = true
set.number = true
set.relativenumber = true
set.wrap = false
set.cursorline = true
set.cursorcolumn = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.signcolumn = "yes"
set.colorcolumn = "80"
set.shortmess:append("A")
set.softtabstop = 4
set.shiftwidth = 4
set.tabstop = 4
set.expandtab = true
set.autoindent = true

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

