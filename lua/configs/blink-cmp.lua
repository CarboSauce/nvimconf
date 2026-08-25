return {
	'saghen/blink.cmp',
	version = '1.*',
	-- @module 'blink.cmp'
	-- @type blink.cmp.Config
	opts = {
		keymap = {
			preset = 'default',
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<Enter>'] = { 'select_and_accept', 'fallback' }
		},
		appearance = {
			nerd_font_variant = 'mono'
		},
		completion = { 
			documentation = {
				auto_show = false
			}
		},
		signature = { enabled = true },
		sources = {
			default = {
				'lsp', 'path', 'snippets', 'buffer'
			}
		},
		fuzzy = { implementation = 'prefer_rust_with_warning' }
	},
	opts_extend = { 'sources.default' }
}
