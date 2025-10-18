local which_key = require 'which-key'

local wkopts_normal = {
    delay = 0,
    triggers = { { '<auto>', mode = {'n', 'x', 's', 'o', 'i', 's', 'c', 't'} } },
    defer = function() return false end,
    win = { padding = { 0, 0 }, border = 'none' },
    plugins = {
        marks = true,
        registers = true,
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
        },
    },
    replace = { desc = {} },
    icons = { keys = { C = 'C-', M = 'A-', D = 'D-', S = 'S-', CR = 'return' } },
}

which_key.setup(wkopts_normal)
