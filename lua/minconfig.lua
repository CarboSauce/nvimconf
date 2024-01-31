vim.cmd 'packadd nvim-autopairs'
vim.cmd 'packadd telescope.nvim'
vim.cmd 'packadd telescope-file-browser.nvim'
vim.cmd 'packadd nvim-treesitter'

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'c', 'cpp', 'lua', 'cmake', 'rust' },
	sync_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	indent = { enable = false }
}

require 'nvim-autopairs' .setup {
	fast_wrap = {
		chars = { '<','{', '[', '(', '"', "'" },
		map = '<M-e>',
		end_key = ')'
	}
}

local tsa = require 'telescope.actions'
require('telescope').setup {
	defaults = {
		mappings = {
			n = {
				["k"] = tsa.move_selection_next,
				["i"] = tsa.move_selection_previous
			}
		},
		preview = {
			hide_on_startup = true
		}
	},
	extensions = {
		file_browser = {
			hijack_netrw = true
		}
	}
}
require("telescope").load_extension "file_browser"

