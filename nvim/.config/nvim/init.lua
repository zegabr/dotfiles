require('custom.debug')
require('custom.maps')
require('custom.sets')

-- PLUGINS
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Treesitter
    require('custom.treesitter'),
    ----Telescope
    require('custom.telescope'),
    ----LSP
    require('custom.cmp'),
    require('custom.lsp'),
    require('custom.jdtls'), -- works better than configuring through lsp
    -- Editor (things I'll hardly modify)
    require('custom.editor'),
    require('custom.undotree'), -- this does not exists on other editors
    require('custom.wilder'),
    -- Latex
    require('custom.tex'),
    -- vimwiki
    require('custom.vimwiki'),
    require('custom.llm'),
    -- Colors and UI
    require('custom.colors'),
}

local opts = {}
require("lazy").setup(plugins, opts)
