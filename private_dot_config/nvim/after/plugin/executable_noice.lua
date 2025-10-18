local noice = require 'noice'

noice.setup {
    lsp = {
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
        },
    },
    presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
    },
    cmdline = {
        format = {
            conceal = false,
            help = false,
            filter = false,
            cmdline = false,
            lua = { pattern = '^:%s*lua%s+', icon = ' ', lang = 'lua' },
        },
    },
    views = {
        cmdline_popupmenu = { size = { width = '70%' } },
        cmdline_popup = { size = { width = '70%' } },
    },
}

vim.keymap.set({ 'n' }, 'çnn', '<cmd>NoiceDismiss<cr>')
vim.keymap.set({ 'n' }, 'çna', '<cmd>NoiceAll<cr>')
