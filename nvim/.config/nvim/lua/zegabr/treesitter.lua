require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash",
        "cpp",
        "dockerfile",
        "gitignore",
        "go",
        "html",
        "java",
        "jq",
        "latex",
        "lua",
        "markdown",
        "python",
        "rust",
        "sql",
        "typescript",
        "vim",
        "yaml",
    },
    sync_install = false,
    auto_install = false,
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
        enable = true,
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']c'] = '@class.outer'
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[c'] = '@class.outer'
            },
        },
        swap = {
            enable = true,
            swap_next = { ["<leader>sw"] = "@parameter.inner" },
        }
    }
}
