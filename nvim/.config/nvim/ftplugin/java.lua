local jdtls_ok, _ = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
end
local config_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux/')
local path_to_lombok = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/lombok.jar')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name
os.execute("mkdir -p" .. workspace_dir)

local config = {
    cmd = {
        vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls'), -- install via mason
        '-data', workspace_dir,
        "-configuration", config_dir,
        '-javaagent:' .. path_to_lombok,
        "--jvm-arg=" .. string.format( "-javaagent:%s", path_to_lombok)
    },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
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
                    -- Use Google Java style guidelines for formatting
                    -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                    -- and place it in the ~/.local/share/eclipse directory
                    -- url = "/.local/share/eclipse/eclipse-java-google-style.xml",
                    -- profile = "GoogleStyle",
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
