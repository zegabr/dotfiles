vim.loader.enable()
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
    -- Colors and UI
    require('custom.colors'),
    -- Treesitter
    require('custom.treesitter'),
    ----Telescope
    require('custom.telescope'),
    -- Editor (things I'll hardly modify)
    require('custom.editor'),
    require('custom.undotree'), -- this does not exists on other editors
    require('custom.wilder'),
    require('custom.git'), -- git specific plugins
    ----LSP (code editing)
    require('custom.cmp'),
    require('custom.lsp'),
    require('custom.nvim-java'),
    -- require('custom.jdtls'),
    -- require('custom.copilot'),

    -- ollama llms
    require('custom.llm'),

    -- Http files
    require('custom.rest'), -- see exmaples here https://github.com/rest-nvim/rest.nvim/tree/main/tests
    -- Latex
    require('custom.tex'),
    -- vimwiki
    require('custom.vimwiki'),
}

local opts = {}
require("lazy").setup(plugins, opts)
