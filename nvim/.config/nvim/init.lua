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
    -- require('custom.copilot'),
    -- java setup.
    require('custom.jdtls'), -- if using this, setup using_nvim_jdtls = true on lsp.lua
    require('custom.jdtls2'),-- if using this, setup using_nvim_jdtls = false on lsp.lua
    -- Editor (things I'll hardly modify)
    require('custom.editor'),
    require('custom.undotree'), -- this does not exists on other editors
    require('custom.wilder'),
    require('custom.rest'), -- see exmaples here https://github.com/rest-nvim/rest.nvim/tree/main/tests
    -- Latex
    require('custom.tex'),
    -- vimwiki
    require('custom.vimwiki'),
    -- ollama llms
    require('custom.llm'),
    -- Colors and UI
    require('custom.colors'),
}

local opts = {}
require("lazy").setup(plugins, opts)

-- useful to know:
-- visual select lines + :norm @<x> to run a macro in multiple lines
