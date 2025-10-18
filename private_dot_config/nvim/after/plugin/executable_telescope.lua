local telescope = require 'telescope'
local builtin = require 'telescope.builtin'

telescope.setup {
    defaults = {
        scroll_strategy = 'limit'
    },
    pickers = {}
}
vim.keymap.set(
    { 'n' }, 'çcs', function()
        builtin.colorscheme {
            enable_preview = true,
            -- sorter = require('telescope.sorters').new {
            --     scoring_function = function()
            --         return math.random()
            --     end,
            -- },
        }
    end, { desc = 'Choose a color scheme' })
