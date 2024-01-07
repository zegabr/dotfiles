return {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
        local path_to_jdtls = vim.fn.expand('~/.local/share/nvim/mason/bin/') .. 'jdtls'
        if not vim.loop.fs_stat(path_to_jdtls) then
            vim.notify "JDTLS not found, running `:LspInstall jdtls`"
            vim.cmd([[:LspInstall jdtls]])
            vim.notify "JDTLS installed, please restart nvim"
            return
        end
        local config_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/config_linux/')
        local path_to_lombok = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls/lombok.jar')
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace/') .. project_name
        os.execute("mkdir -p " .. workspace_dir)

        local google_java_format_path = vim.fn.expand('~/.local/share/') .. 'eclipse/'
        if not vim.loop.fs_stat(google_java_format_path) then
            print('DOWNLOADING GOOGLE JAVA FORMAT')
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
                path_to_jdtls, -- install via mason
                '-data', workspace_dir,
                "-configuration", config_dir,
                '-javaagent:' .. path_to_lombok,
                "--jvm-arg=" .. string.format("-javaagent:%s", path_to_lombok)
            },
            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
            settings = {
                java = {
                    eclipse = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = "interactive",
                        runtimes = {
                            {
                                name = "JavaSE-17",
                                path = vim.fn.expand("/usr/lib/jvm/java-17-openjdk-amd64/"),
                            },
                            {
                                name = "JavaSE-11",
                                path = vim.fn.expand("/usr/lib/jvm/java-11-openjdk-amd64/"),
                            },
                            {
                                name = "JavaSE-1.8",
                                path = vim.fn.expand("/usr/lib/jvm/java-8-openjdk-amd64/"),
                            },
                        },
                    },
                    maven = {
                        downloadSources = true,
                    },
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
        require('custom.maps').on_attach(nil, vim.api.nvim_get_current_buf())
    end
}
