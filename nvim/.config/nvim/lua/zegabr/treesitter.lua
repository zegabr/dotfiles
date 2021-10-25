require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    indent = {
        enable = true
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true
    },
    textobjects = {
        enable = true
    }
}
