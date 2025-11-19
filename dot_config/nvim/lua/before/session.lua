local filename = (vim.fn.stdpath 'state') .. '/Session.vim'
if vim.uv.fs_stat(filename) then
    vim.schedule(function()
        vim.cmd.source(filename)
        vim.schedule(function()
            vim.uv.fs_unlink(filename)
        end)
    end)
end
vim.keymap.set('n', '<leader>r', function()
    vim.cmd('mksession! ' .. filename .. ' | restart')
end)
-- local id = vim.env.KITTY_PID or vim.env.ALACRITTY_WINDOW_ID
-- if id then
--     local filename = (vim.fn.stdpath 'state')
--         .. '/session-'
--         .. id
--         .. '.vim'
--     vim.keymap.set('n', '<leader>r', function()
--         vim.cmd('mksession! ' .. filename)
--         vim.cmd 'restart'
--     end)
--     if vim.uv.fs_stat(filename) then
--         require 'very-lazy'(function()
--             vim.schedule(function()
--                 vim.cmd.source(filename)
--                 vim.schedule(function()
--                     vim.uv.fs_unlink(filename)
--                 end)
--             end)
--         end)
--     end
-- end
