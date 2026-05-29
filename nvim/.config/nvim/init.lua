require("core.utils")
require("core.options")
require("core.keymaps")

-- Dynamically load all plugins in lua/plugins/
local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)
for _, file in ipairs(plugin_files) do
    local plugin_name = vim.fn.fnamemodify(file, ":t:r")
    require("plugins." .. plugin_name)
end

-- vim.pack user commands
vim.api.nvim_create_user_command("VimPackUpdate", function() vim.pack.update() end, { desc = "Update vim.pack plugins" })
vim.api.nvim_create_user_command("VimPackAdd", function(opts) vim.pack.add(opts.args) end, { nargs = 1, desc = "Add a vim.pack plugin" })
vim.api.nvim_create_user_command("VimPackDel", function(opts) vim.pack.del(opts.args) end, { nargs = 1, desc = "Delete a vim.pack plugin" })
