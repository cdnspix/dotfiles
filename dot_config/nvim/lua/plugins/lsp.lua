return {
    {
        'neovim/nvim-lspconfig',
        event = 'FileType',
        dependencies = {
            'https://git.sr.ht/~p00f/clangd_extensions.nvim',
            'mrcjkb/rustaceanvim',
            'cordx56/rustowl',
            'saecki/crates.nvim',
            'vxpm/ferris.nvim',
            'olrtg/nvim-emmet',
        },
        config = function()
            -- vim.lsp.enable 'angularls'
            vim.lsp.enable 'clangd'
            vim.lsp.enable 'cmake'
            vim.lsp.enable 'css_variables'
            vim.lsp.enable 'cssls'
            vim.lsp.enable 'cssmodules_ls'
            vim.lsp.enable 'html'
            vim.lsp.enable 'lua_ls'
            vim.lsp.enable 'markdown_oxide'
            vim.lsp.enable 'eslint'
            vim.lsp.enable 'eslint'
            vim.lsp.enable 'emmet_language_server'
            -- vim.lsp.enable 'tsgo'
            vim.lsp.enable 'ts_ls'
            vim.diagnostic.config {
                virtual_lines = true,
            }
        end,
        keys = {
            { 'K', function()
                vim.lsp.buf.hover { silent = true, focusable = false }
            end }
        },
    },
    {
        'olrtg/nvim-emmet',
        keys = {
            { 'çemm', function() require 'nvim-emmet'.wrap_with_abbreviation() end, mode = { 'n', 'v' } },
        },
    },
    'Saghen/blink.cmp',
    event = 'UIEnter',
    enabled = not vim.g.disable_blink,
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    build = 'cargo build --release',
    ---@type blink.cmp.Config
    opts = {
        completion = {
            list = {
                max_items = math.huge,
                selection = {
                    preselect = false, auto_insert = false,
                },
            },
            menu = {
                auto_show = true,
            },
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
        },
        cmdline = { enabled = false },
        snippets = {
            active = function() return false end,
        },
        sources = {
            default = { 'lsp' },
        },
        signature = { enabled = true },
        fuzzy = {
            implementation = 'prefer_rust',
            prebuilt_binaries = {
                download = false,
            },
        },
        keymap = {
            preset = 'default',
        },
    },
}
