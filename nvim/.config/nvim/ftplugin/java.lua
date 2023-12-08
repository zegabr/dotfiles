local jdtls_ok, _ = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
end
local config_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux/')
local path_to_lombok = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/lombok.jar')
-- TODO: change this if needed
local path_to_jar =
    vim.fn.expand(
        '~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231012-1237.jar')

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
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org"
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            import = { enabled = true },
            rename = { enabled = true },
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
        },
    },
    init_options = {
        bundles = {}
    }
}

-- This starts a new client & server, or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
