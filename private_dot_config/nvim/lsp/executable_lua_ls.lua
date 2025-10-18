return {
    root_markers = { '.editorconfig' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            semantic = { enable = true },
            format = { enable = true },
            workspace = {
                checkThirdParty = false,
                preloadFileSize = 50000,
                library = {
                    vim.fn.stdpath 'config', vim.fn.stdpath 'data',
                    vim.env.VIMRUNTIME, '${3rd}/luv/library',
                },
            },
            completion = {
                autoRequire = true,
                callSnippet = 'Both',
                displayContext = 50,
                keywordSnippet = 'Disable',
                showWord = 'Disable',
                workspaceWord = false,
            },
            diagnostics = {
                workspaceRate = 10,
                libraryFiles = 'Opened',
                workspaceDelay = 3000,
                workspaceEvent = 'OnSave',
            },
            hint = { enable = true, paramName = 'All', setTime = true },
            hover = { enable = true, enumsLimit = 50 },
        },
    },
    on_init = function(client) end,
}
