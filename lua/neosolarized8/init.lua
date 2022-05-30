local theme = require('neosolarized8.theme')

local M = {}

vim.cmd [[ packadd! colorbuddy.nvim ]]

M.setup = function(options)
    return theme.setup(options)
end

M.apply = function(config)
    theme.apply(config)
end

M.colorscheme = function()
    M.apply()
end

return M
