require('refactoring').setup({
    prompt_func_return_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
    },
    prompt_func_param_type = {
        go = true,
        java = true,
        cpp = true,
        c = true,
    },
    printf_statements = {},
    print_var_statements = {},
})

-- load refactoring Telescope extension (should be called after telescope setup)
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
    "v",
    "<leader>re",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)
