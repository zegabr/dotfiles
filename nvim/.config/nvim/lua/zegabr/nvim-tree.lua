-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- nested options are documented by accessing them with `.` (eg: `:help nvim-tree.view.mappings.list`).
require('nvim-tree').setup { -- Overriding default opts
  open_on_tab = true,
  sort_by = "name",
  view = {
    width = 40,
    height = 30,
    hide_root_folder = false,
    number = true,
    relativenumber = true,
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
} -- END_DEFAULT_OPTS


local keymap = require('zegabr.keymap')
local noremap = keymap.nnoremap
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

noremap("<Leader>e", ":NvimTreeFindFileToggle<cr>")
