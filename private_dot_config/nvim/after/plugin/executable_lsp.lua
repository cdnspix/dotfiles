vim.lsp.config('tailwindcss', {
    cmd = {
        'fnm',
        'exec',
        '--using=24',
        'npm',
        'exec',
        'tailwindcss-language-server',
        '--',
        '--stdio',
    }
})
vim.lsp.config('eslint', {
    cmd = {
        'fnm',
        'exec',
        '--using=24',
        'npm',
        'exec',
        'vscode-eslint-language-server',
        '--',
        '--stdio',
    }
})
vim.lsp.config('cssmodules_ls', {
    cmd = {
        'fnm',
        'exec',
        '--using=24',
        'npm',
        'exec',
        'cssmodules-language-server',
        '--',
        '--stdio',
    }
})
vim.lsp.config('css_variables', {
    cmd = {
        'fnm',
        'exec',
        '--using=24',
        'npm',
        'exec',
        'css-variables-language-server',
        '--',
        '--stdio',
    }
})
local M = setmetatable(
    {}, {
        __index = function(s, x)
            vim.lsp.enable(x)
            return s
        end,
    })
vim.lsp.config(
    '*', { capabilities = require 'blink.cmp'.get_lsp_capabilities() })
vim.g.enable_these_servers = M
.emmylua_ls
.clangd
.jsonls
.cmake
.ts_ls
.html
.cssls
.css_variables
.tailwindcss
.cssmodules_ls
.digestif
.eslint
.fennel_ls
.yamlls
.java_language_server
.zls

local tca = require 'tiny-code-action'

local phonykey = function(k)
    vim.keymap.set('n', k, function() end, { desc = k .. ' does nothing' })
end
phonykey 'grd'
phonykey 'gri'
phonykey 'gra'
phonykey 'grf'
phonykey 'grd'
phonykey 'grD'
phonykey 'grt'

vim.api.nvim_create_autocmd(
    { 'LspAttach' }, {
        callback = function(event)
            local bufnr = event.buf
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            -- vim.bo[bufnr].formatexpr = nil
            -- client.server_capabilities.semanticTokensProvider = nil
            -- vim.treesitter.stop()
            if client:supports_method 'textDocument/diagnostic'
                or client:supports_method 'textDocument/publishDiagnostics' then
                vim.diagnostic.config {
                    vitual_lines = true,
                    virtual_text = false,
                }
                vim.keymap.set('n', 'grt', function()
                    vim.diagnostic.config {
                        virtual_lines = not vim.diagnostic.config().virtual_lines
                    }
                end, { desc = 'Enable virtual lines' })
            end
            if client:supports_method 'textDocument/codeAction' then
                tca.setup {}
                vim.keymap.set(
                    { 'n' }, 'gra', function()
                        tca.code_action {}
                    end, { desc = 'Code Action LSP', buffer = bufnr })
                if client:supports_method 'textDocument/inlayHint' then
                    vim.lsp.inlay_hint.enable(false)
                    vim.keymap.set(
                        { 'n' }, 'gri', function()
                            if vim.lsp.inlay_hint.is_enabled { bufnr = bufnr } then
                                vim.lsp.inlay_hint
                                    .enable(false, { bufnr = bufnr })
                            else
                                vim.lsp.inlay_hint
                                    .enable(true, { bufnr = bufnr })
                            end
                        end, { buffer = bufnr, desc = 'Toggle Inlay Hint' })
                end
                if client:supports_method 'textDocument/foldingRange' then
                    local win = vim.api.nvim_get_current_win()
                    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
                end
                if client:supports_method 'textDocument/formatting' then
                    vim.keymap.set({ 'n' }, 'grf', function()
                        vim.lsp.buf.format {
                            async = true,
                        }
                    end, { desc = 'Format LSP', buffer = bufnr })
                end
                if client:supports_method 'textDocument/completion' then
                end
                if client:supports_method 'textDocument/definition' then
                    vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition, { desc = 'Definition LSP', buffer = bufnr })
                    vim.keymap.set({ 'n' }, 'grD', vim.lsp.buf.declaration, { desc = 'Declaration LSP', buffer = bufnr })
                end
            end
        end,
    })
