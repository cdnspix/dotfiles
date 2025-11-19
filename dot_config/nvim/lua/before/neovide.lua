if not vim.g.neovide then return end
vim.opt.guifont = { 'monospace' }
local fixed_opts = {
    scale_factor = 0.8,
}
for k, v in pairs(fixed_opts) do
    vim.g['neovide_' .. k] = v
end
local create_operator = function(name, fn)
    return function(...)
        local value = vim.g['neovide_' .. name]
        local new_value = fn(value)
        vim.g['neovide_' .. name] = new_value
    end
end
NVBigger = create_operator('scale_factor', function(x) return x + 0.02 end)
NVSmaller = create_operator('scale_factor', function(x) return x - 0.02 end)
vim.keymap.set('n', '<C-_>', NVSmaller)
vim.keymap.set('n', '<C-+>', NVBigger)
