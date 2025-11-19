local sync_with_default = {
    colorcolumn = '+1',
    -- conceallevel = 0,
    -- cursorcolumn = true,
    -- cursorline = true,
    equalalways = false,
    expandtab = true,
    exrc = true,
    fillchars = 'eob: ',
    foldcolumn = '0',
    foldmethod = 'expr',
    foldenable = false,
    formatoptions = 'jql',
    helpheight = 0,
    hidden = true,
    numberwidth = 3,
    signcolumn = 'number',
    scrolloff = 5,
    statuscolumn = '%s%C%l',
    softtabstop = -1,
    shiftwidth = 4,
    switchbuf = { 'useopen', 'vsplit' },
    tabstop = 4,
    textwidth = 80,
    winfixheight = true,
    winfixwidth = true,
    wrapscan = false,
}
local data = require 'data-persist' 'options'
local ops = data.get()
for k, v in pairs(sync_with_default) do
    local o = ops[k]
    if o and o ~= vim.NIL then
        vim.opt[k] = o
    else
        vim.opt[k] = v
    end
end
require 'very-lazy'(function()
    vim.api.nvim_create_autocmd('OptionSet', {
        callback = function(e)
            if vim.list_contains(vim.tbl_keys(sync_with_default), e.match)
                and vim.v.option_type == 'global'
                and vim.v.option_new ~= nil
            then
                data.set(function(x)
                    if not x or x == vim.NIL then x = {} end
                    x[e.match] = vim.v.option_new
                    return x
                end)
            end
        end,
    })
end)
local color = require 'data-persist' 'color'
local sc = function()
    vim.schedule(function()
        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function(e)
                color.set(e.match)
            end
        })
    end)
end
local co = color.get()
if co and co ~= vim.NIL then
    require 'very-lazy'(function()
        vim.cmd.colorscheme(co)
        sc()
    end)
else
    sc()
end
