return {
    -- this will only work well on nvidia gpu
    'David-Kunz/gen.nvim',
    lazy = true,
    config = function()
        -- require('gen').model = 'codellama' # default = 'mistral:instruct'
    end,
}
