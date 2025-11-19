vim.g.auto_save_enabled = true
local get = function(buf, v)
    return vim.api.nvim_get_option_value(v, { buf = buf })
end
local name = vim.api.nvim_buf_get_name
local group = vim.api.nvim_create_augroup('AutoSave', { clear = false })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
    group = 'AutoSave',
    callback = function(event)
        if not vim.g.auto_save_enabled then return end
        local buf = event.buf
        if vim.b[buf].auto_save_disabled then return end
        if #get(buf, 'buftype') > 0 then return end
        if #name(buf) == 0 then return end
        if not get(buf, 'modifiable') then return end
        if not get(buf, 'modified') then return end
        vim.cmd 'silent! update'
    end,
})
