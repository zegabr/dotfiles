local using_nvim_jdtls = true -- make this false if using nvim-java
if not using_nvim_jdtls then
    require('java').setup()
end

return {
    externally_attached = { -- will not be setup via mason_lspconfig
        jdtls = using_nvim_jdtls,
    },

    server_settings = {
        lua_ls = {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                        }
                    },
                }
            },
        },

        gopls = {
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                },
                staticcheck = true,
            },
            extra_on_attatch = function(bufnr)
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    pattern = '*.go',
                    callback = function()
                        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
                    end
                })
            end
        },

        eslint = {
            extra_on_attatch = function(bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
                    command = "EslintFixAll",
                })
            end
        },

        bashls = {
            filetypes = { 'sh', '.bash_aliases', '.bashrc', '.bash_aliases_work', '.profile', '.bash_profile' },
        }
    },

}
