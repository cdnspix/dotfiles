return {
    'romgrk/barbar.nvim',
    event = 'UIEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
    },
    keys = {
        { '<C-l>', '<cmd>BufferPrevious<cr>',  silent = true },
        { '<C-h>', '<cmd>BufferNext<cr>' , silent = true },
        { '<C-k>', '<cmd>BufferClose<cr>', silent = true },
    },
}
