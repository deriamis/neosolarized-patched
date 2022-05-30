local theme = {
    light = {
    	base03  = '#fdf6e3',
    	base02  = '#eee8d5',
    	base01  = '#93a1a1',
    	base00  = '#839496',
    	base0   = '#657b83',
    	base1   = '#586e75',
        base2   = '#073642',
    	base3   = '#002b36',
     },
    dark = {
        base03  = '#002b36',
        base02  = '#073642',
        base01  = '#586e75',
        base00  = '#657b83',
        base0   = '#839496',
        base1   = '#93a1a1',
        base2   = '#eee8d5',
        base3   = '#fdf6e3',
    },
    midnight = {
        base03  = '#171717',
        base02  = '#073642',
        base01  = '#586e75',
        base00  = '#657b83',
        base0   = '#7e8082',
        base1   = '#93a1a1',
        base2   = '#eee8d5',
        base3   = '#fdf6e3',
    },
}

local accents = {
    yellow     = '#b58900',
    orange     = '#cb4b16',
    red        = '#dc322f',
    magenta    = '#d33682',
    violet     = '#6c71c4',
    blue       = '#268bd2',
    cyan       = '#2aa198',
    green      = '#859900',
}

local M = {}

M.config = function(config)
    config = config or require('neosolarized8.config').new()
    local palette = accents

    for k, v in pairs(theme[config.theme]) do
        palette[k] = v
    end

    return palette
end

return M
