require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "css",
        "go",
        "gomod",
        "graphql",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "python",
        "regex",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    indent = {
        enable = true
    },
    highlight = {
        enable = true,
        --additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true
    },
    textobjects = {
        enable = true
    }
}
