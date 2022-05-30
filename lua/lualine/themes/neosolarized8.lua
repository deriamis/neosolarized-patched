local c = require("neosolarized8.palette").config()

return {
    normal = {
        a = { fg = c.base03, bg = c.blue, gui = 'bold' },
        b = { fg = c.base03, bg = c.base1 },
        c = { fg = c.base1,  bg = c.base02 },
    },
    insert =  {
        a = { fg = c.base03, bg = c.green, gui = 'bold' },
        b = { fg = c.base03, bg = c.base1 },
        c = { fg = c.base1,  bg = c.base02 },
    },
    visual =  {
        a = { fg = c.base03, bg = c.magenta, gui = 'bold' },
        b = { fg = c.base03, bg = c.base1 },
        c = { fg = c.base1,  bg = c.base02 },

    },
    replace = {
        a = { fg = c.base03, bg = c.red, gui = 'bold' },
        b = { fg = c.base03, bg = c.base1 },
        c = { fg = c.base1, bg = c.base02 },
    },
    command = {
        a = { fg = c.base03, bg = c.base01, gui = 'bold' },
        b = { fg = c.base03, bg = c.base1 },
        c = { fg = c.base1,  bg = c.base02 },
    },
    inactive = {
        a = { fg = c.base0,  bg = c.base02, gui = 'bold' },
        b = { fg = c.base03, bg = c.base00 },
        c = { fg = c.base01, bg = c.base02 },
    },
}
