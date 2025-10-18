if not vim.g.neovide then return false end
local fpers = require 'priv.fpers'
local seta = function(v) vim.g.neovide_scale_factor = tonumber(v) or 1 end
local geta = function()
    return string.format('%f\n', vim.g.neovide_scale_factor or 1)
end
local vpers = fpers((vim.fn.stdpath 'state') .. '/neovide', geta, seta)
vim.schedule(vim.cmd.redraw)
vim.keymap.set(
    { 'n' }, '<C-->', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05
        vpers()
    end)
vim.keymap.set(
    { 'n' }, '<C-=>', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05
        vpers()
    end)

local vide_options = { cursor_smooth_blink = true, refresh_rate = 75 }
vim.iter(vide_options):each(function(k, v) vim.g['neovide_' .. k] = v end)

