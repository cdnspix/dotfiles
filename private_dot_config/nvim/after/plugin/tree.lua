local nt = require 'nvim-tree'
local api = require 'nvim-tree.api'

local on_attach = function(bufnr)
    local m = function(k)
        return function(d)
            return function(f)
                vim.keymap.set({ 'n' }, k, f, { desc = d, buffer = bufnr })
            end
        end
    end
    m '<A-.>' 'Enlarge Neo Tree' (function()
        api.tree.resize { relative = 1 }
    end)
    m '<A-,>' 'Shrink NeoTree' (function()
        api.tree.resize { relative = - 1 }
    end)
    m 'l' 'Edit' (api.node.open.edit)
    m 'h' 'Go up' (api.tree.change_root_to_parent)
    m '.' 'Set dir' (api.tree.change_root_to_node)
    m 'd' 'Delete' (api.fs.trash)
    m 'r' 'Rename' (api.fs.rename)
    m 'a' 'Create' (api.fs.create)
    m 'D' 'debug node' (function()
        print(vim.inspect(api.tree.get_node_under_cursor()))
    end)
end

nt.setup {
    on_attach = on_attach,
    sync_root_with_cwd = true,
}

vim.keymap.set({ 'n' }, '\\', function()
    api.tree.toggle()
end, { nowait = true, desc = 'Toggle Tree' })
