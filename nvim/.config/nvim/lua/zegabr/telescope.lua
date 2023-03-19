local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")

local mymappings = {
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
            ".git/"
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

local function project_files()
    local ok = pcall(builtin.git_files)
    if not ok then builtin.find_files() end
end

vim.keymap.set('n', '<leader><leader>h', builtin.help_tags, { desc = '[H]elp' })
vim.keymap.set("n", "<leader><leader>tk", builtin.keymaps, { desc = 'telescope keymaps' })

vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = 'telescope git branchs' })
vim.keymap.set("n", "<leader>glo", builtin.git_commits, { desc = 'git log' })
vim.keymap.set("n", "<leader>glof", builtin.git_bcommits, { desc = 'git log current file' })

vim.keymap.set("n", "<leader><leader>b", builtin.buffers, { desc = 'telescope buffers' })
vim.keymap.set("n", "<leader><leader>p", project_files, { desc = 'Project File Search' })
vim.keymap.set("n", "<leader><leader>f", function()
    builtin.grep_string({
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = '',
    }, { desc = 'Project String Search' })
end)
