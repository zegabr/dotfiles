vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)
-- TODO: go :h netrw
-- learn how to use netrw to:
-- open file: press enter
-- - create file near current file: use %
-- - move file or folder : just press R to rename it
--
-- define an enumeration of supported operations
local Operations = {
    DELETE = "delete",
    COPY = "copy",
}

local function netrw_file_or_folder_operation(op)
    -- get the current directory or file in netrw
    local line = vim.api.nvim_get_current_line()
    local curdir = vim.api.nvim_buf_get_var(0, "netrw_curdir")

    -- construct the full path to the file or folder
    local path = string.format("%s/%s", curdir, line)

    -- create the command to perform the specified operation
    local command
    if op == Operations.DELETE then
        command = string.format("!rm -rf %s", path)
    elseif op == Operations.COPY then
        local newpath = string.sub(path, 1, string.len(path))
        command = string.format("!cp -r %s %s.copy", path, newpath)
    end

    -- run the command using the neovim API
    vim.api.nvim_command(command)
    vim.api.nvim_command(":file!")
end

function Netrw_delete_folder_or_file()
    netrw_file_or_folder_operation(Operations.DELETE)
end

function Netrw_copy_folder_or_file()
    netrw_file_or_folder_operation(Operations.COPY)
end

vim.cmd([[
"-- - delete folder: put cursor at file or folder
autocmd Filetype netrw nmap <buffer> <leader>D :lua Netrw_delete_folder_or_file()<CR>-<CR>
"-- - copy folder to other place: press <leader>C
autocmd Filetype netrw nmap <buffer> <leader>C :lua Netrw_copy_folder_or_file()<CR>-<CR>
]])
