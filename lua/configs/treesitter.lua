return {
	'nvim-treesitter/nvim-treesitter',
	config = function()
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = { 'c', 'cpp', 'lua', 'cmake', 'rust' },
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = false }
		}
	end
}
