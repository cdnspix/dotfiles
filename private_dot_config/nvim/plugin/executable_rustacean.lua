vim.g.rustaceanvim = function()
    ---@type rustaceanvim.Opts
    local config = {
        server = {
            settings = {
                ['rust-analyzer'] = {
                    completion = {
                        fullFunctionSignatures = { enable = true },
                        termSearch = { enable = true },
                    },
                    diagnostics = { styleLints = { enable = true } },
                    hover = {
                        show = { fields = 50 },
                        actions = { references = { enable = true } },
                    },
                    inlay_hints = {
                        bindingModeHints = { enable = true },
                        closureCaptureHints = { enable = true },
                        closureReturnTypeHints = { enable = true },
                        expressionAdjustmentHints = { enable = true },
                        implicitDrops = { enable = true },
                    },
                },
            },
        },
    }
    return config
end
