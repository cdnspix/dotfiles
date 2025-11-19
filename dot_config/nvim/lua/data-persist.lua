local uv = vim.uv
local js = vim.json
return function(x)
    local persist_file = (vim.fn.stdpath 'state') .. '/persist-state/' .. x .. '.json'
    local ensure_file = function()
        if not uv.fs_stat((vim.fn.stdpath 'state') .. '/persist-state') then
            uv.fs_mkdir((vim.fn.stdpath 'state') .. '/persist-state', tonumber('755', 8))
        end
        if not uv.fs_stat(persist_file) then
            local f = assert(uv.fs_open(persist_file, 'w', tonumber('644', 8)))
            uv.fs_write(f, '')
            uv.fs_close(f)
        end
    end
    local reset_file = function()
        local f = assert(uv.fs_open(persist_file, 'w', tonumber('644', 8)))
        uv.fs_write(f, '')
        uv.fs_close(f)
    end
    local get_content = function()
        ensure_file()
        local f = assert(uv.fs_open(persist_file, 'r', tonumber('644', 8)))
        local ok, d = pcall(js.decode, assert(uv.fs_read(f, 1024 * 1024)))
        if not ok then
            reset_file()
            return vim.NIL
        end
        return d
    end
    local set_content = function(d)
        if type(d) == 'function' then
            d = d(get_content())
        end
        local f = assert(uv.fs_open(persist_file, 'w', tonumber('644', 8)))
        uv.fs_write(f, js.encode(d))
        uv.fs_close(f)
    end
    return { get = get_content, set = set_content }
end
