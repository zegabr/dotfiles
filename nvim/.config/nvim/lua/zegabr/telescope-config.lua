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
        vimgrep_arguments = { --TODO: fix this to add regex?? this is not finding any "require(" (only "require\("), i shouldn't have to escape the parentesis
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
            hidden = true
        },
    }
}

local builtin = require('telescope.builtin')
local keymap = require('zegabr.keymap')
local nnoremap = keymap.nnoremap

local project_files = function()
  local opts = {hidden=true} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then builtin.find_files(opts) end
end


 nnoremap("<C-p>", function() project_files() end)
 nnoremap("<C-f>", function() builtin.live_grep() end)
 nnoremap("<C-b>", function() builtin.buffers() end)
 nnoremap("<leader>gb", function() builtin.git_branches() end)
