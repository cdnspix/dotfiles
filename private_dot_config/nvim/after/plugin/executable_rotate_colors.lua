local fpers = require 'priv.fpers'
local tbuiltin = require 'telescope.builtin'
local tsorters = require 'telescope.sorters'
local colorpersist = fpers(
                         (vim.fn.stdpath 'state') .. '/colorscheme',
                         function() return vim.g.colors_name end, function(v)
        vim.g.colors_name = v
        vim.cmd.colorscheme(v)
    end)
vim.api.nvim_create_autocmd(
    { 'ColorScheme' }, {
        callback = function(e)
            vim.g.colors_name = e.match
            colorpersist()
        end,
    })

local colors = vim.fn.getcompletion('', 'color')
local randcolo = function()
    vim.cmd.colorscheme(colors[math.random(#colors)])
end
vim.keymap.set({ 'n' }, 'Ç', randcolo, { nowait = true })
-- vim.keymap.set({ 'n' }, 'Çr', function()
--     tbuiltin.colorscheme {
--         enable_preview = true,
--         sorter = tsorters.new {
--             scoring_function = function() return math.random() end,
--         },
--     }
-- end)
