local snacks = require 'snacks'

local dirs = (vim.fn.stdpath 'state') .. '/directories'

local getdirlist = function()
    local list = {}
    local f = vim.uv.fs_open(dirs, 'r', 420)
    local d = vim.uv.fs_read(f, 1024 * 1024 * 1024, 0)
    vim.uv.fs_close(f)
    local lines = vim.split(d, '\n', { trimempty = true, plain = true })
    for i, v in ipairs(lines) do
        local x = vim.split(v, '\t', { trimempty = true, plain = true })
        table.insert(list, x)
    end
    return list
end

local getuses = function(dirlist)
    local list = {}
    for i, dirent in ipairs(dirlist) do
        local when = dirent[1]
        local dir = dirent[2]
        list[dir] = list[dir] or {}
        table.insert(list[dir], when)
    end
    return list
end

local getfrequency = function(uses)
    local list = {}
    for d, u in pairs(uses) do
        table.insert(list, { d, #u })
    end
    table.sort(list, function(x, y) return x[2] > y[2] end)
    local onlydirs = {}
    for i, v in ipairs(list) do
        table.insert(onlydirs, v[1])
    end
    return onlydirs
end

vim.g.getdirlist = getdirlist
vim.g.getuses = getuses
vim.g.getfrequency = getfrequency

-- snacks.setup {
--     dashboard = {
--         sections = {
--             {
--                 section = 'projects',
--                 indent = 2,
--                 padding = 2,
--                 limit = 99,
--                 dirs = function()
--                     return getfrequency(getuses(getdirlist()))
--                 end,
--                 action = function(d)
--                     vim.cmd.tcd(d)
--                     vim.cmd.bd()
--                     require 'nvim-tree.api'.tree.open()
--                 end
--             },
--         },
--     },
-- }
