local dirs = (vim.fn.stdpath 'state') .. '/directories'
local add_dir = function(dir)
    local f = vim.uv.fs_open(dirs, 'a', 420)
    vim.uv.fs_write(f, string.format('%d\t%s\n', vim.uv.clock_gettime('realtime').sec, dir), 0)
    vim.uv.fs_close(f)
end

vim.api.nvim_create_autocmd({ 'DirChanged' }, {
    callback = function(e)
        add_dir(e.file)
    end,
})
