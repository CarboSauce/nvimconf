local packer = require('packer')
local use = packer.use
packer.startup({function()
	-- themes
	use 'base16-project/base16-vim'
	use 'LunarVim/horizon.nvim'
	use 'sindrets/oxocarbon-lua.nvim'
	-- plugins
	use "nvim-telescope/telescope-file-browser.nvim"
	use {
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		requires = {'nvim-tree/nvim-web-devicons'}
	}
	use 'stevearc/dressing.nvim'
	use 'lewis6991/impatient.nvim'
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use {
		'ilyachur/cmake4vim',
		disable = true
	}
	use 'Shatur/neovim-cmake'
	use 'mfussenegger/nvim-dap'
	use 'windwp/nvim-autopairs'
	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim'}
	}
	use {
		'akinsho/toggleterm.nvim', tag = 'v2.*', opt = false
	}
	use {
		'akinsho/bufferline.nvim',
		lock = true,
		requires = {'kyazdani42/nvim-web-devicons'}
	}
	use 'nvim-treesitter/nvim-treesitter-context'
	use 'nvim-treesitter/nvim-treesitter'
	use {
    	'kyazdani42/nvim-tree.lua',
    	requires = {'kyazdani42/nvim-web-devicons', opt = true},
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true}
	}
	end,
	config = {
		display = {
			open_fn = require'packer.util'.float
		}
	}
})
