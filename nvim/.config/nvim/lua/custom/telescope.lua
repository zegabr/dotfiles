return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local action_state = require("telescope.actions.state")
        local mymappings = {
            ['<esc>'] = actions.close, -- this ensures i don't have a normal mode meaning i only press esc once to close it
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<tab>'] = actions.toggle_selection,
            ['<cr>'] = function(pb) -- TODO: change this to file edit all when this issue is closed https://github.com/nvim-telescope/telescope.nvim/issues/416
                local picker = action_state.get_current_picker(pb)
                local multi = picker:get_multi_selection()
                actions.select_default(pb) -- the normal enter behaviour
                for _, j in pairs(multi) do
                    if j.path ~= nil then  -- is it a file -> open it as well:
                        vim.cmd(string.format("%s %s", "edit", j.path))
                    end
                end
            end,
        }

        local picker_settings = {
            find_command = { "fd", "--strip-cwd-prefix", "--type", "f" },
            hidden = true,
        }
        telescope.setup {
            defaults = {
                mappings = { i = mymappings, n = mymappings, },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim",
                    "--hidden",
                },
                file_ignore_patterns = {
                    "node_modules/",
                    "Session.vim",
                    ".git/",
                    "build/",
                    "target/",
                    ".idea/",
                    ".dart_tools/",
                }
            },
            pickers = {
                find_files = picker_settings,
                git_files = picker_settings,
            },
        }
        local builtin = require('telescope.builtin')
        local function project_files()
            local ok = pcall(builtin.git_files)
            if not ok then builtin.find_files() end
        end
        vim.keymap.set('n', '<leader><leader>h', builtin.help_tags, { desc = '[H]elp' })
        vim.keymap.set("n", "<leader><leader>k", builtin.keymaps, { desc = 'telescope keymaps' })

        -- use this more, it's a good replacement for leaning harpoon, if used with :bp :bn and :bd
        vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = 'telescope buffers' })
        vim.keymap.set("n", "<leader><leader>o", builtin.oldfiles, { desc = 'find recently opened files' })

        vim.keymap.set("n", "<leader><leader>p", project_files, { desc = 'Project File Search' })
        vim.keymap.set("n", "<leader><leader>f", function()
            builtin.grep_string({
                shorten_path = true,
                search = '',
            }, { desc = 'Project String Search' })
        end)
        -- TODO: add leadreleader f to search for visual selected text (better than copying and pasting into usual grep_string)
    end,
}
