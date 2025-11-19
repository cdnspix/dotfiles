return {
    'folke/which-key.nvim',
    enabled = not vim.g.disable_which_key,
    event = 'VeryLazy',
    opts = {
        preset = 'classic',
        delay = 0,
        triggers = {
            { '<auto>', mode = 'nixsotc' },
        },
        win = {
            height = { max = 120 },
            wo = {
                winblend = 20,
            },
            padding = { 1, 1 },
        },
        layout = {
            width = { max = 640 },
        },
        keys = {
            scroll_down = '',
            scroll_up = '',
        },
    }
}
