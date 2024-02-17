return {
	'nvim-treesitter/nvim-treesitter',
	config = function()
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = {
				'c',
				'cpp',
				'lua',
				'cmake',
				'rust',
				'typescript'
			},
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = false },
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = true,
				filetypes = {
					"html",
					"typescriptreact"
				}
			},
		}
	end
}
