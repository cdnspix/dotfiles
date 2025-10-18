vim.loader.enable()
if vim.env.NVIM_PROFILE then
    vim.defer_fn(function() print(vim.g.loadertime) end, 2000)
    local init_time = vim.uv.hrtime()
    local original_require = require
    require = function(x)
        local requires = vim.g.all_requires or {}
        local requires2 = vim.g.all_requires2 or {}
        if not requires[x] then
            local t = vim.uv.hrtime() - init_time
            requires[x] = t
            table.insert(requires2, { x, t / 1000000.0 })
        end
        vim.g.all_requires = requires
        vim.g.all_requires2 = requires2
        return original_require(x)
    end
    vim.g.requires_sort = function()
        table.sort(vim.g.all_requires2, function(a, b) return a[2] > b[2] end)
        local deltas = {}
        local last_time = 0
        for _i, V in ipairs(vim.g.all_requires2) do
            local k = V[1]
            local v = V[2]
            table.insert(deltas, { k, v - last_time })
            last_time = v
        end
        local sdeltas = vim.deepcopy(deltas, true)
        table.sort(sdeltas, function(a, b) return a[2] > b[2] end)
        vim.g.the_deltas = deltas
        vim.g.the_sdeltas = sdeltas
    end
    vim.schedule(function()
        vim.g.loaded_time = vim.uv.hrtime() - init_time
        vim.g.requires_sort()
    end)
end
