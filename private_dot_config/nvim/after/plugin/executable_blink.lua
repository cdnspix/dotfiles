local blink = require 'blink.cmp'

---@type blink.cmp.Config
local blink_config = {
    snippets = { preset = 'luasnip' },
    signature = { enabled = true, window = {treesitter_highlighting = false } },
    completion = {
        documentation = { auto_show = true, treesitter_highlighting = false },
        accept = { auto_brackets = { enabled = true } },
        menu = { auto_show = true, draw = {treesitter = {} }},
        list = { cycle = { from_top = false, from_bottom = false } },
    },
    sources = {
        default = {
            'lsp', 'snippets',
            -- 'path',
        },
        providers = { cmdline = {} },
    },
    keymap = {
        preset = 'none',
        ['<C-n>'] = {
            function(cmp)
                if not blink.is_menu_visible() then
                    blink.show()
                    blink.show_documentation()
                    blink.show_signature()
                    return true
                end
            end,
            'select_next',
        },
        ['<C-p>'] = {
            function(cmp)
                if not blink.is_menu_visible() then
                    blink.show()
                    blink.show_documentation()
                    blink.show_signature()
                    return true
                end
            end,
            'select_prev',
        },
        ['<C-t>'] = {
            function(cmp)
                if blink.snippet_active() then
                    blink.snippet_forward()
                    blink.show_documentation()
                    blink.show_signature()
                    return true
                end
            end,
        },
        ['<C-d>'] = {
            function(cmp)
                if blink.snippet_active() then
                    blink.snippet_previous()
                    blink.show_documentation()
                    blink.show_signature()
                    return true
                end
            end,
        },
        ['<C-y>'] = { 'accept', 'fallback' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down' },
        ['<C-b>'] = { 'scroll_documentation_up' },
        ['<A-p>'] = { 'scroll_signature_up' },
        ['<A-n>'] = { 'scroll_signature_down' },
    },
}
blink.setup(blink_config)

--   scroll_documentation_down = <function 25>,
--   scroll_documentation_up = <function 26>,
--   scroll_signature_down = <function 27>,
--   scroll_signature_up = <function 28>,
--   select_accept_and_enter = <function 29>,

-- {
--   accept = <function 1>,
--   accept_and_enter = <function 2>,
--   add_filetype_source = <function 3>,
--   add_provider = <function 4>,
--   add_source_provider = <function 5>,
--   cancel = <function 6>,
--   get_context = <function 7>,
--   get_items = <function 8>,
--   get_lsp_capabilities = <function 9>,
--   get_selected_item = <function 10>,
--   get_selected_item_idx = <function 11>,
--   hide = <function 12>,
--   hide_documentation = <function 13>,
--   hide_signature = <function 14>,
--   insert_next = <function 15>,
--   insert_prev = <function 16>,
--   is_active = <function 17>,
--   is_documentation_visible = <function 18>,
--   is_ghost_text_visible = <function 19>,
--   is_menu_visible = <function 20>,
--   is_signature_visible = <function 21>,
--   is_visible = <function 22>,
--   reload = <function 23>,
--   resubscribe = <function 24>,
--   select_and_accept = <function 30>,
--   select_next = <function 31>,
--   select_prev = <function 32>,
--   setup = <function 33>,
--   show = <function 34>,
--   show_and_insert = <function 35>,
--   show_and_insert_or_accept_single = <function 36>,
--   show_documentation = <function 37>,
--   show_signature = <function 38>,
--   snippet_active = <function 39>,
--   snippet_backward = <function 40>,
--   snippet_forward = <function 41>
-- }
--
