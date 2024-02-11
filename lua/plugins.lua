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
	{ import = "configs" },
	{ 'lunacookies/vim-colors-xcode' },
	{ 'RRethy/nvim-base16' },
	{ 'LunarVim/horizon.nvim' },
	-- plugins
	{ 
		"nvim-telescope/telescope-file-browser.nvim",
		config = function()
			require 'telescope'.load_extension 'file_browser'
		end
	},
	'famiu/bufdelete.nvim',
	{
		'stevearc/dressing.nvim',
		opts = {
			winblend = 0
		}
	},
	{
		'dgagn/diagflow.nvim',
		opts = {}
	},
	{
		'Wansmer/treesj',
		keys = {
			{
				"<leader>J", "<cmd>TSJToggle<cr>", desc = "Join Toggle"
			}
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 150
		}
	},
	{ 
		'Shatur/neovim-cmake',
		opts = {
			build_dir = function()
				return vim.fn.getcwd() .. '/.cmakebuild'
			end,
			parameters_file = '.cmakebuild/neovim.json',
			configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja Multi-Config' },
			copy_compile_commands = false
		}
	},
	'mfussenegger/nvim-dap',
	{
		'windwp/nvim-autopairs',
		opts = {
			fast_wrap = {
				chars = { '<','{', '[', '(', '"', "'" },
				map = '<M-e>',
				end_key = ')'
			}
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
			defaults = {
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
	},
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		opts = {
			float_opts = {
				border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
			},
			open_mapping = '<c-t>',
			direction = 'float',
			persist_mode = false -- start always in insert mode
		}
	},
	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = {'nvim-tree/nvim-web-devicons'},
		opts = {
			options = {
				mode = 'tabs'
			}
		}
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		opts = {
			enable = true,
			patterns = {
				default = {
					'class',
					'function',
					'method'
				}
			}
		}
	},
})
