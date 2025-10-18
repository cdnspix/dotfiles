-- vim.api.nvim_create_autocmd(
--     { 'VimEnter' }, { callback = function() vim.cmd 'helptags ALL' end })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    callback = function(ev)
        vim.treesitter.stop(ev.buf)
    end
})
-- vim.api.nvim_create_autocmd({ 'V)
-- vim.api.nvim_create_autocmd(
--     { 'LspAttach' }, {
--         callback = function(e)
--             local client_id = assert(e.data.client_id)
--             local client = assert(vim.lsp.get_client_by_id(client_id))
--             if client:supports_method 'textDocument/completion' then
--                 local chars = {};
--                 for i = 32, 126 do
--                     table.insert(chars, string.char(i))
--                 end
--                 client.server_capabilities.completionProvider.triggerCharacters = chars
--                 vim.lsp.completion.enable(
--                     true, client_id, e.buf, { autotrigger = true })
--             end
--             if client:supports_method 'textDocument/formating' then
--                 vim.bo[e.buf].formatexpr = 'v:lua.vim.lsp.formatexpr(#{timeout_ms:1000})'
--                 -- vim.keymap.set({ 'n' },'çfo', function() vim.lsp.buf.format {} end, { buffer = 0 })
--             end
--         end,
--     })
