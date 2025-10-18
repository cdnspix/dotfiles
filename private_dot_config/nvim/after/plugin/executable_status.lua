local set_highlights = function()
    vim.cmd [[
       highlight stli guibg=cyan guifg=black    
       highlight stln guibg=#a0ffd0 guifg=black
       highlight stlv guibg=#00ffa0 guifg=black
       highlight stlvv guibg=yellow guifg=black
       highlight stlc guibg=#c0c0c0 guifg=black
       highlight stlt guibg=#c000c0 guifg=white
       highlight wbi guibg=#e0c0c0 guifg=#303030 gui=bold
       highlight wba guibg=#0080e0 guifg=white gui=underdotted
    ]]
end
set_highlights()

local path_short = function(p)
    local cf = vim.fn.stdpath 'config'
    local dt = vim.fn.stdpath 'data'
    local pk = dt .. '/site/pack/packages/start'
    local cc = vim.fn.stdpath 'cache'
    local st = vim.fn.stdpath 'state'
    local hm = vim.env.HOME
    return p:gsub(cf, '(config)'):gsub(pk, '(plugin)'):gsub(dt, '(data)'):gsub(
               cc, '(cache)'):gsub(hm, '(home)')
end

local getft = function()
    return vim.api.nvim_get_option_value('filetype', { buf = 0 })
end

local modf = function()
    if #vim.api.nvim_get_option_value('buftype', { buf = 0 }) > 0 then
        return ''
    end
    local modified = vim.api.nvim_get_option_value('modified', { buf = 0 })
    return modified and '[...]' or '[]'
end
local search = function()
    local results = vim.fn.searchcount { recompute = true, maxcount = 999999 }
    local curwidth = #tostring(results.current)
    local totwidth = #tostring(results.total)
    return string.format(
               string.format('<%%%dd/%%%dd>', curwidth, totwidth),
               results.current, results.total)
end

local is_current = function()
    local this = tostring(vim.api.nvim_get_current_win())
    local global = vim.g.actual_curwin
    return global and global == this
end

local win_size = function()
    local w = vim.api.nvim_win_get_width(0)
    local h = vim.api.nvim_win_get_height(0)
    return '[' .. tostring(w) .. '×' .. tostring(h) .. ']'
end

local colors = function()
    return '/' .. (vim.g.colors_name or '') .. '/'
end

vim.g.statusline_eval = function()
    local mode = string.sub(vim.fn.mode(1), 1, 1):gsub('V', 'vv')
    return '%#stl' .. (mode or '') .. '#' .. '[' .. vim.fn.mode(1) .. '] (' ..
                vim.fn.getcwd() .. ')%=' .. colors() ..  ' ' .. search()
    .. '%S'
end

vim.g.winbar_eval = function()
    return
        (is_current() and '%#wba#' or '%#wbi#') .. '[%f]' .. modf() .. '%=' ..
            win_size() .. ' %l/%L(%c)'
end

vim.opt.statusline = '%{%v:lua.vim.g.statusline_eval()%}'

vim.api.nvim_create_autocmd(
    { 'ColorScheme', 'UIEnter' }, { callback = set_highlights })

vim.api.nvim_create_autocmd(
    { 'BufWinEnter' }, {
        callback = function(e)
            local buf = e.buf
            if vim.bo[buf].buftype ~= 'nofile' and #vim.fn.bufname('%') > 0 then
                vim.opt_local.winbar = '%{%v:lua.vim.g.winbar_eval()%}'
            end
        end,
    })
