local packer = require('packer')
local use = packer.use
packer.startup({function()
	-- themes
	use 'base16-project/base16-vim'
	use 'yassinebridi/vim-purpura'
	use 'cseelus/vim-colors-lucid'
	use 'LunarVim/horizon.nvim'
	-- plugins
	use 'glepnir/dashboard-nvim'
	use 'stevearc/dressing.nvim'
	use 'lewis6991/impatient.nvim'
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'ilyachur/cmake4vim'
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
   	use 'jackguo380/vim-lsp-cxx-highlight'
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
