P = function(v)
    print(vim.inspect(v))
    return v
end

-- basic
require('zegabr.maps')
require('zegabr.sets')
require('zegabr.netrw')
require('zegabr.colors')

-- plugins
require('zegabr.plugins')

-- ide features
require('zegabr.telescope')
require('zegabr.lsp')
