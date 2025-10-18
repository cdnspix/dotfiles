local _ = function(key, path, o)
    vim.keymap.set({ 'n' }, key, function() vim.cmd.tcd(path) end, { desc = o })
end

_('çcn', vim.fn.stdpath 'config', 'Go to config folder')
_('çcp', vim.fn.stdpath 'data', 'Go to data folder')
_('çck', '~/.config/kitty', 'Go to kitty folder')
_('çcs', '~/.config/kitty', 'Go to sway folder')
_('çcK', '~/.config/kitty', 'Go to kanata folder')
