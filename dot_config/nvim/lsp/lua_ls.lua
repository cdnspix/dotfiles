return {
    root_markers = { 'init.lua' },

    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            semantic = { enable = true },
            workspace = {
                checkThirdParty = false,
                preloadFileSize = 50000,
                library = vim.api.nvim_list_runtime_paths(),
            },
            completion = {
                autoRequire = true,
                callSnippet = 'Both',
                displayContext = 9999,
                keywordSnippet = 'Disable',
                showWord = 'Disable',
                workspaceWord = false,
            },
            diagnostics = {
                workspaceRate = 100,
                libraryFiles = 'Opened',
                workspaceDelay = 500,
                workspaceEvent = 'OnSave',
            },
            hint = { enable = true, paramName = 'All', setTime = true },
            hover = {
                enable = true,
                enumsLimit = 9999,
                viewStringMax = 9999,
            },
            ['type'] = {
                inferTableSize = 9999,
            },
            format = {
                enable = true,
                defaultConfig = {},
            },
            typeFormat = {
                config = {
                    auto_complete_end = true,
                    auto_complete_table_sep = true,
                    format_line = true,
                },
            },
        },
    },
    on_init = function(client) end,
}
