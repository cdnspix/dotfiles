local conv = function(c)
    c = c / 256
    local r = (c / (256 * 256))
    local g = ((c / 256) % 256)
    local b = (c % 256)
    return (r + g + b) / 3
end
local light_or_dark = function()
    local hinorm = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local bg = conv(hinorm.bg or 0)
    local fg = conv(hinorm.fg or 0)
    return (bg > fg) and 'light' or 'dark'
end
local Randcolorscheme = function()
    local col = vim.fn.getcompletion('', 'color')
    vim.cmd.colorscheme(col[vim.fn.rand() % #col + 1])
end
local RandomLight
RandomLight = function()
    Randcolorscheme()
    if light_or_dark() == 'dark' then vim.schedule(RandomLight) end
end
local RandomDark
RandomDark = function()
    Randcolorscheme()
    if light_or_dark() == 'light' then vim.schedule(RandomDark) end
end
vim.keymap.set({ 'n' }, 'çipl', function() IPrefer = 'light' end)
vim.keymap.set({ 'n' }, 'çipd', function() IPrefer = 'dark' end)
vim.keymap.set({ 'n' }, 'çipp', function() IPrefer = '' end)
vim.keymap.set({ 'n' }, 'Ç', function()
    if IPrefer == 'light' then
        RandomLight()
    elseif IPrefer == 'dark' then
        RandomDark()
    else
        Randcolorscheme()
    end
end)
