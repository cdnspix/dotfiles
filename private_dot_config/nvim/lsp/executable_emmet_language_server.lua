local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').emmet_language_server.setup {
    capabilities = caps,
    init_options = { showSuggestionsAsSnippets = true },
}
