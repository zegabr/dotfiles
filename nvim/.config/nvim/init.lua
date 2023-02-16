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

-- utils
require('zegabr.gitutils')

-- ide features
require('zegabr.undotree') -- this does not exits in vscode u.u
require('zegabr.telescope')
require('zegabr.lsp')
