local inst = (vim.uv.os_environ() or {}).NVIM_INSTANCE_LOCKFILE

local data_dir = vim.fn.stdpath 'data'
local pkgs_dir = data_dir .. '/site/pack/packages/start'

local log = function(x) print(vim.inspect(x)) end

local download_from_git = function(url, name)
    vim.system({ 'mkdir', '--parents', pkgs_dir }):wait()
    local this_pkg_dir = pkgs_dir .. '/' .. name
    local lock = inst and (inst .. '/pkg-lock.' .. name) or nil
    if lock then vim.uv.fs_open(lock, 'w', 420) end
    if not vim.uv.fs_stat(this_pkg_dir) then
        vim.system({ 'git', 'clone', '--depth=1', url, this_pkg_dir }, function()
            if lock then vim.uv.fs_unlink(lock) end
        end)
    else
        vim.system({ 'git', 'pull' }, { cwd = this_pkg_dir }, function()
            if lock then vim.uv.fs_unlink(lock) end
        end)
    end
end

local update = function()
    local packages = vim.g.packages_to_install
    for k, v in pairs(packages) do download_from_git(v.url, k) end
end

local purge = function() vim.system({ 'rm', '-rf', pkgs_dir }):wait() end

local clean = function()
    vim.system({ 'mkdir', '--parents', pkgs_dir }):wait()
    local packages = vim.g.packages_to_install
    local should_delete = {}
    for _, pkg in pairs(vim.fn.readdir(pkgs_dir)) do
        should_delete[pkg] = true
    end
    for name, _ in pairs(packages) do should_delete[name] = nil end
    for name, _ in pairs(should_delete) do
        vim.system({ 'rm', '-rf', pkgs_dir .. '/' .. name }):wait()
    end
end

vim.api.nvim_create_user_command(
    'Packages', function(a)
        local args = a.args
        if args == 'purge' then
            purge()
        elseif args == 'clean' then
            clean()
        elseif args == 'update' then
            update()
        elseif args == 'sync' then
            clean()
            update()
        elseif args == 'reboot' then
            purge()
            update()
        else
            print 'Error, no such operation'
        end
    end, { nargs = 1 })
