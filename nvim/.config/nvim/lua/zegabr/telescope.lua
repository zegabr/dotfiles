local telescope = require('telescope')

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim", -- add this value
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

local project_files = function()
    local ok = pcall(builtin.git_files)
    if not ok then builtin.find_files() end
end

nnoremap("<C-p>", function() project_files() end)
nnoremap("<C-f>", function() builtin.grep_string({
    shorten_path = true,
    word_match = "-w",
    only_sort_text = true,
    search = '',
}) end)

nnoremap("<C-b>", function() builtin.buffers() end)
nnoremap("<leader>gb", function() builtin.git_branches() end)

--" git log
nnoremap("<leader>gl", builtin.git_commits)

--" git log in file
nnoremap("<leader>glf", builtin.git_bcommits)

-- fzf through yanks
require('neoclip').setup()
require('telescope').load_extension("neoclip")
nnoremap("<leader>y", "<cmd>Telescope neoclip a extra=star,plus,b<cr>")
