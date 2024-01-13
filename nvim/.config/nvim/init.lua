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

    ----LSP (code editing)
    require('custom.cmp'),
    require('custom.lsp'),

    -- ollama llms
    require('custom.llm'),
    -- vimwiki
    require('custom.vimwiki'),
    -- Http files
    require('custom.rest'), -- see exmaples here https://github.com/rest-nvim/rest.nvim/tree/main/tests


    -- git specific plugins
    require('custom.git'),

    -- not used much
    -- require('custom.latex'), -- requires some cargo packages found on ../../../scripts/scripts/stuff/r.sh
    -- require('custom.copilot'),
}

local opts = {}
require("lazy").setup(plugins, opts)
