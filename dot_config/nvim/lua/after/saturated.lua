local mcolors = require 'mini.colors'
local saturate = function()
    vim.defer_fn(function()
        mcolors.get_colorscheme()
        :chan_add('saturation', 60, { filter = 'fg' })
        :chan_add('saturation', -20, { filter = 'bg' })
        :apply()
    end, 200)
end
saturate()
vim.api.nvim_create_autocmd('ColorScheme', {
    callback = saturate,
})

