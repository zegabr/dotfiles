-- TODO: change this if needed
local config_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux/')
local path_to_lombok = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/lombok.jar')
local path_to_jar =
vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar')

local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir " .. workspace_dir)

local config = {
    cmd = {
        --
        "java", -- Or the absolute path '/path/to/java11_or_newer/bin/java'
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        '-javaagent:' .. path_to_lombok,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", path_to_jar,
        "-configuration", config_dir,
        "-data", workspace_dir,
    },
    root_dir = root_dir,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            import = { enabled = true },
            rename = { enabled = true }
        }
    },
    init_options = {
        bundles = {}
    }
}

-- TODO: test removing this
-- config['on_attach'] = function(client, bufnr)
    -- require "lsp_signature".on_attach({
        -- bind = true, -- This is mandatory, otherwise border config won't get registered.
        -- floating_window_above_cur_line = false,
        -- padding = '',
        -- handler_opts = {
            -- border = "rounded"
        -- }
    -- }, bufnr)
-- end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
