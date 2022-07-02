vim.opt.termguicolors = true
vim.opt.showmode = false
vim.g.airline_theme="deus"
vim.opt.background="dark"

require("gruvbox").setup({ -- must be called before colorshceme gruvbox
  undercurl = true,
  underline = true,
  bold = true,
  italic = false, -- will make italic comments and special strings
  inverse = true, -- invert background for search, diffs, statuslines and errors
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  contrast = "", -- can be "hard" or "soft"
  overrides = {},
})
vim.cmd[[ colorscheme gruvbox ]]

require('lualine').setup({
    options = { theme = 'gruvbox' },
    tabs = {
        sections = {
            lualine_a = {
                {
                    'tabs',
                    max_length = vim.o.columns / 3, -- Maximum width of tabs component.
                    -- Note:
                    -- It can also be a function that returns
                    -- the value of `max_length` dynamically.
                    mode = 0, -- 0: Shows tab_nr
                    -- 1: Shows tab_name
                    -- 2: Shows tab_nr + tab_name

                    tabs_color = {
                        -- Same values as the general color option can be used here.
                        active = 'lualine_{section}_normal',     -- Color for active tab.
                        inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
                    },
                }
            }
        }
    }
})

require('tabline').setup {
    enable = true,
    options = {
        show_filename_only = false, -- shows base filename only instead of relative path in filename
        modified_icon = "+ ", -- change the default modified icon
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
    }
}
vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
