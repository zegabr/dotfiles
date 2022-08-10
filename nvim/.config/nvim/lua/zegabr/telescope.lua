local telescope = require('telescope')
local actions = require('telescope.actions')

local custom_actions = {}
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<tab>'] = actions.toggle_selection + actions.move_selection_previous,
                ['<s-tab>'] = actions.toggle_selection + actions.move_selection_next,
                ['<cr>'] = custom_actions.fzf_multi_select,
            },
            n = {
                ['<esc>'] = actions.close,
                ['<tab>'] = actions.toggle_selection + actions.move_selection_previous,
                ['<s-tab>'] = actions.toggle_selection + actions.move_selection_next,
                ['<cr>'] = custom_actions.fzf_multi_select
            }
        },

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
        }
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        git_files = {
            hidden = true,
        },
    },
}

local builtin = require('telescope.builtin')
local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

local function project_files()
    local ok = pcall(builtin.git_files)
    if not ok then builtin.find_files() end
end

nnoremap("<leader>p", function() project_files() end)
nnoremap("<leader>f", function() builtin.grep_string({
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = '',
    })
end)

nnoremap("<leader>bu", function() builtin.buffers() end)
nnoremap("<leader>gb", function() builtin.git_branches() end)

--" git log
nnoremap("<leader>glo", builtin.git_commits)

--" git log in file
nnoremap("<leader>glof", builtin.git_bcommits)

-- fzf through yanks
require('neoclip').setup()
telescope.load_extension("neoclip")
nnoremap("<leader>y", "<cmd>Telescope neoclip a extra=star,plus,b<cr>")
