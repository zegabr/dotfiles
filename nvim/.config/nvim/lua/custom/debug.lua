P = function(v)
    print(vim.inspect(v))
    return v
end

-- prints the result of P(v) to the current buffer, if it's stringfiable
Pbuf = function (v)
    local bufnr = vim.fn.bufnr("")
    local lines = vim.split(P(v), "\n")
    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
end


