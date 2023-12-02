-- TODO: change this if needed
local jdtls_dir = '/home/ze/.local/share/nvim/mason/packages/jdtls/'
local config_dir = jdtls_dir .. 'config_linux'
local plugins_dir = jdtls_dir .. 'plugins/'
local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher.cocoa.macosx.x86_64_1.2.700.v20221108-1024.jar'

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir " .. workspace_dir)

local config = {
    cmd = { jdtls_dir },
    root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1]),
}

config['on_attach'] = function(client, bufnr)
    require 'keymaps'.map_java_keys(bufnr);
    require "lsp_signature".on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window_above_cur_line = false,
        padding = '',
        handler_opts = {
            border = "rounded"
        }
    }, bufnr)
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
