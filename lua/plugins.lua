local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'cseelus/vim-colors-lucid'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'yassinebridi/vim-purpura' 
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'ilyachur/cmake4vim'	
	use {
		'romgrk/barbar.nvim',
		lock = true,
		requires = {'kyazdani42/nvim-web-devicons'}
	}
   	use 'jackguo380/vim-lsp-cxx-highlight' 
	use {
    	'kyazdani42/nvim-tree.lua',
    	requires = {'kyazdani42/nvim-web-devicons', opt = true},
	}
	use 
	{
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true}
	}
end)
