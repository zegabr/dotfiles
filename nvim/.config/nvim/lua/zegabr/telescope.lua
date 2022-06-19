local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

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

-- workaround for multi select
function custom_actions.fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    local picker = action_state.get_current_picker(prompt_bufnr)
    for _, entry in ipairs(picker:get_multi_selection()) do
      vim.cmd(string.format("%s %s", ":e!", entry.value))
    end
    vim.cmd('stopinsert')
  else
    actions.file_edit(prompt_bufnr)
  end
end

local M = {}

M.project_files = function()
  local opts = {hidden=true} -- define here if you want to define something
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

return M

