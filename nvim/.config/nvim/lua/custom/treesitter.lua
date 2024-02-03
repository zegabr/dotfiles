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
                -- essential
                "bash", "comment", "lua", "luadoc", "vim", "vimdoc", "diff", "gitcommit", "markdown", "markdown_inline", "xml", "yaml",
                -- most used
                "javascript", "typescript", "go", "c", "cpp", "python", "kotlin", "java", "html", "jsdoc", "rust", "sql", "tsx",
            },
            sync_install = false,
            auto_install = true, -- works since i will have treesitter cli installed
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
