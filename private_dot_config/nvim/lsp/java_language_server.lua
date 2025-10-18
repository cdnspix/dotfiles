return {
    cmd = { '/home/caio/codes/forks/java-language-server/dist/lang_server_linux.sh' },
    settings = {
        filetypes = { 'java' },
    },
    handlers = {
        ['client/registerCapability'] = function(e, r, ct, cf)
            local registration = {
                registrations = { r },
            }
            return vim.lsp.handlers['client/registerCapability'](e, registration, ct, cf)
        end,
    }
}
