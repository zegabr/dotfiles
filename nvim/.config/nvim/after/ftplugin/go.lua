Go_snippets = {
    if_err_return = function()
        vim.api.nvim_input("oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
    end,
}
vim.cmd([[command! GoIffErrSnippet lua Go_snippets.if_err_return()]])
