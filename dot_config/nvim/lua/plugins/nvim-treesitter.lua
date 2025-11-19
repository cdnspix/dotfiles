return {
    'nvim-treesitter/nvim-treesitter',
    enabled = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
        local tsconfig = {
            ensure_installed = {},
            auto_install = true,
            sync_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = { enable = true },
            textobjects = {
                enable = true,
                lookahead = true,
            },
        }
        ---@class TSContext.UserConfig
        local tscontext = {
            enable = true,
        }
        require('nvim-treesitter').setup()
        require('nvim-treesitter.configs').setup(tsconfig)
        require('treesitter-context').setup(tscontext)
    end
}
