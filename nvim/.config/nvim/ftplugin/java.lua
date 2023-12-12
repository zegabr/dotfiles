local jdtls_ok, _ = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
    return
end
local config_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux/')
local path_to_lombok = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/lombok.jar')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name
os.execute("mkdir -p " .. workspace_dir)

local google_java_format_path = vim.fn.expand('~/.local/share/') .. 'eclipse/'
if not vim.loop.fs_stat(google_java_format_path) then
    print('BAIXANDO OOOGLE JAVA FORMAT')
    os.execute("mkdir -p " .. google_java_format_path)
    vim.fn.system({
        "curl",
        "-o",
        google_java_format_path .. 'eclipse-java-google-style.xml',
        "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
    })
end

local config = {
    cmd = {
        vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls'), -- install via mason
        '-data', workspace_dir,
        "-configuration", config_dir,
        '-javaagent:' .. path_to_lombok,
        "--jvm-arg=" .. string.format("-javaagent:%s", path_to_lombok)
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
                    -- url = "~/.local/share/eclipse/eclipse-java-google-style.xml", -- uncomment this if used
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
local bufnr = vim.api.nvim_get_current_buf()
local bufopts = { buffer = bufnr, noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, bufopts)
vim.keymap.set('n', '<leader>A', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, bufopts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_next, bufopts)
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, bufopts)
