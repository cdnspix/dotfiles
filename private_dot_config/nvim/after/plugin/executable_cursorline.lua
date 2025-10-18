vim.api.nvim_create_autocmd(
    { 'WinLeave' }, {
        callback = function()
            vim.opt_local.cursorline = false
            vim.opt_local.cursorcolumn = false
        end,
    })
vim.api.nvim_create_autocmd(
    { 'WinEnter' }, {
        callback = function()
            vim.opt_local.cursorline = true
            vim.opt_local.cursorcolumn = true
        end,
    })
