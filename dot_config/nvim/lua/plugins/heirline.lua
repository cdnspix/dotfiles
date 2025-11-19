-- return {
--     'vim-airline/vim-airline',
-- }
-- return {
--     'nvim-lualine/lualine.nvim',
--     dependencies = {
--         'nvim-lualine/lualine.nvim.wiki',
--     },
--     opts = {},
-- }
return {
    'rebelot/heirline.nvim',
    -- enabled = false,
    event = 'UIEnter',
    dependencies = {
        'rebelot/heirline.nvim.wiki',
        'zeioth/heirline-components.nvim',
        'zeioth/heirline-components.nvim.wiki',
    },
    config = function()
        local heirline = require 'heirline'
        local components = require 'heirline-components.all'
        local c = components.component
        local utils = require 'heirline.utils'
        components.init.subscribe_to_events()
        heirline.load_colors(components.hl.get_colors())
        heirline.setup {
            opts = {
                disable_winbar_cb = function(args)
                    return not require 'heirline-components.buffer'.is_valid(args.buf)
                    or components.condition.buffer_matches {
                        buftype = { 'terminal', 'prompt', 'nofile', 'help', 'quickfix' },
                        filetype = { 'NvimTree', 'neo%-tree', 'dashboard', 'Outline', 'aerial', 'rnvimr', 'yazi' },
                    }
                end,
            },
            statusline = {
                c.cmd_info {
                    show_cmd = {},
                },
                c.diagnostics {

                },
                c.file_info {

                },
                c.mode {
                    mode_text = {},
                },
                { provider = '%=' },
                c.nav {

                },
                c.treesitter {

                },
                c.lsp {
                },
            },
            winbar = {
                c.breadcrumbs {

                },
                { provider = '%=' },
                c.file_info {
                    filename = {},
                    file_modified = {},
                }
            },
        }
    end,
}
