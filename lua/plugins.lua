local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--depth=1",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 'lunacookies/vim-colors-xcode' },
	{ 'RRethy/nvim-base16' },
	{ 'LunarVim/horizon.nvim' },
	-- plugins
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{
		'glepnir/dashboard-nvim',
		event = 'VimEnter',
		dependencies = {'nvim-tree/nvim-web-devicons'}
	},
	'famiu/bufdelete.nvim',
	'stevearc/dressing.nvim',
	'wbthomason/packer.nvim',
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'saadparwaiz1/cmp_luasnip',
	'L3MON4D3/LuaSnip',
	'Shatur/neovim-cmake',
	'mfussenegger/nvim-dap',
	'windwp/nvim-autopairs',
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {'nvim-lua/plenary.nvim'}
	},
	{
		'akinsho/toggleterm.nvim', version = '*'
	},
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = {'kyazdani42/nvim-web-devicons'}
	},
	'nvim-treesitter/nvim-treesitter-context',
	'nvim-treesitter/nvim-treesitter',
	{
    	'kyazdani42/nvim-tree.lua',
    	dependencies = {'kyazdani42/nvim-web-devicons'},
	},
	{
		'nvim-lualine/lualine.nvim',
    	dependencies = {'kyazdani42/nvim-web-devicons'},
	}

})
