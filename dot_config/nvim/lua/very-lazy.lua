return function(fn, ...)
    local varargs = { ... }
    vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
            fn(unpack(varargs))
        end,
    })
end
