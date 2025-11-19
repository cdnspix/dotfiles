vim.keymap.set('n', '<leader>q', '<cmd>qa!<cr>', { silent = true })
vim.keymap.set('n', '<leader>Q', '<cmd>cq<cr>', { silent = true })
vim.keymap.set('n', '<Esc>', function()
    vim.cmd 'nohlsearch'
    vim.api.nvim__redraw { tabline = true, winbar = true, statusline = true, statuscolumn = true, cursor = true, valid = false, flush = true }
    return '<Esc>'
end, { remap = true, silent = true })
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '<C-a>', 'a <Esc>h<C-a>lxh', { silent = true })
vim.keymap.set('n', '<C-x>', 'a <Esc>h<C-x>lxh', { silent = true })
vim.keymap.set('i', 'Çç', function() require('which-key').show() end, { silent = true })
vim.keymap.set({ 'n', 'v' },'gy', '"+y', { silent = true })
vim.keymap.set('n', 'gp', '"+p', { silent = true })
vim.keymap.set({ 'n', 'v' },'gY', '"+Y', { silent = true })
vim.keymap.set('n', 'gP', '"+P', { silent = true })
vim.keymap.del('n', 'K')
-- require 'very-lazy'(vim.keymap.del, 'i', '<Tab>')
