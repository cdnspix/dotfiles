local r = function(x)
    local ok, err = pcall(require, 'before.' .. x)
    if not ok then vim.schedule(function() vim.print(err) end) end
end
r 'neovide'
r 'opts'
r 'keymaps'
r 'session'
r 'auto-save'
r 'cursor'
r 'colors'
r 'fuck-treesitter'
