local M = {}
local _M = { instance = false }
local mode = 420
M.get = function(p)
    local f = vim.uv.fs_open(p, 'r', mode)
    local d = vim.uv.fs_read(f, 1024 * 1024, 0)
    vim.uv.fs_close(f)
    return d
end
M.set = function(p, d)
    local f = vim.uv.fs_open(p, 'w', mode)
    if not f then return false end
    local r = vim.uv.fs_write(f, d, 0)
    vim.uv.fs_close(f)
    if r then return true end
end
_M.__unm = function(s)
    print('__unm', s.path)
    if s.instance == true then
        s.setter(M.get(s.path))
        return math.random(50, 100)
    end
end
_M.__call = function(s, path, getter, setter)
    if s.instance == true then
        M.set(s.path, s.getter())
        return math.random(0, 50)
    else
        vim.schedule(function() setter(M.get(path)) end)
        return setmetatable(
                   {
                instance = true,
                path = path,
                getter = getter,
                setter = setter,
            }, _M)
    end
end

return setmetatable(M, _M)
