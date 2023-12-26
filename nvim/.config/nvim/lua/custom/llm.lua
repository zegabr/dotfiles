return {
    -- this will only work well on nvidia gpu
    'David-Kunz/gen.nvim',
    cmd = 'Gen',
    config = function()
        -- require('gen').model = 'codellama' # default = 'mistral:instruct'
    end,
}
