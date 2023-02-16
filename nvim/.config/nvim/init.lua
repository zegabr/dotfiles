P = function(v)
    print(vim.inspect(v))
    return v
end

-- basic
require('zegabr.maps')
require('zegabr.sets')
require('zegabr.netrw')

-- plugins
require('zegabr.plugins')

-- colors
require('zegabr.treesitter')
require('zegabr.colors')

-- utils
require('zegabr.gitutils')

-- ide features
require('zegabr.undotree') -- this does not exits in vscode u.u
require('zegabr.telescope')
require('zegabr.lsp')
