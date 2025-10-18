local treesitter = require 'nvim-treesitter.configs'

treesitter.setup {
    ensure_installed = {
        'c', 'lua', 'rust',
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
