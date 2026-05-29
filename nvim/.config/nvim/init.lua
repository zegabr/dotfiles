require("core.utils")
require("core.options")
require("core.keymaps")

-- Dynamically load all plugins in lua/plugins/
local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)
for _, file in ipairs(plugin_files) do
    local plugin_name = vim.fn.fnamemodify(file, ":t:r")
    require("plugins." .. plugin_name)
end

