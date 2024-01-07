return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
    },
    build = function()
        require('nvim-treesitter.install').update({ with_sync = true })()
    end,
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                "bash",
                "bibtex",
                "c",
                "c_sharp",
                "clojure",
                "cmake",
                "comment",
                "commonlisp",
                "cpp",
                "css",
                "diff",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "graphql",
                "groovy",
                "haskell",
                "html",
                "http",
                "java",
                "javascript",
                "jq",
                "json",
                "kotlin",
                "latex",
                "lua",
                "markdown",
                "markdown_inline",
                "nix",
                "ocaml",
                "perl",
                "php",
                "proto",
                "python",
                "r",
                "regex",
                "rust",
                "scala",
                "sql",
                "starlark",
                "svelte",
                "swift",
                "textproto",
                "thrift",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "zig",
            },
            sync_install = false,
            auto_install = true,
            indent = { enable = true },
            highlight = { enable = true, },
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
    end,
}
