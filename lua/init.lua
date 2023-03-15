-- General configs
vim.api.nvim_create_user_command('Fmt', vim.lsp.buf.formatting, { nargs = 0 })
vim.api.nvim_create_user_command('Fmtrange', vim.lsp.buf.range_formatting, { nargs = 0 })
vim.api.nvim_create_user_command('Impl', vim.lsp.buf.definition, { nargs = 0 })
vim.api.nvim_create_user_command('Rename', function() vim.lsp.buf.rename() end, { nargs = 0 })
vim.api.nvim_create_user_command('Hover', vim.lsp.buf.hover, { nargs = 0 })
vim.api.nvim_create_user_command('Codeaction', vim.lsp.buf.code_action, { nargs = 0 })
vim.api.nvim_create_user_command('Diag', vim.diagnostic.open_float, { nargs = 0 })
-- LUA LINE
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'horizon',
		component_separators = { left = '│', right = '│' },
		section_separators = { left = '│', right = '│' },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}

}
-- LSP STUFF
local capabs = vim.lsp.protocol.make_client_capabilities()
capabs = require('cmp_nvim_lsp').default_capabilities(capabs)
local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local path = require 'plenary.path'
vim.diagnostic.config {
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false
}
-- CCLS CONFIG
root_files = {
	'.clang-format',
	'CMakeLists.txt',
	'Makefile',
	'.cmakebuild/compile_commands.json',
	'.clangd',
}
function cxx_root_dir()
	return util.root_pattern(unpack(root_files))(vim.fn.getcwd())
end

if vim.g.use_clangd then
	lspconfig.clangd.setup {
		cmd = {
			"clangd", 
			"--compile-commands-dir=./.cmakebuild",
			"--background-index", "--clang-tidy",
			"--enable-config"
		},
		capabilities = capabs,
		root_dir = cxx_root_dir
	}
else
	lspconfig.ccls.setup {
		init_options = {
			cache = {
				directory = ".cmakebuild/ccls"
			},
			compilationDatabaseDirectory = ".cmakebuild",
			completion = {
				placeholder = false
			},
			highlight = {
				lsRanges = true
			},
		},
		root_dir = cxx_root_dir,
		capabilities = capabs,
		single_file_support = true
	}
end
-- RUST ANALYZER
lspconfig.serve_d.setup{}
lspconfig.rust_analyzer.setup {
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self";
			},
			--cargo = {
			--	buildScripts = {
			--		enable = true,
			--	}
			--},
			procMacro = {
				enable = true
			}
		}
	}
}


-- SUMNEKO LSP
-- reference: https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
-- local sumneko_binary_path = vim.fn.exepath('lua-language-server')
-- -- TODO: Idk if :h paremeter is enough to make stuff work on linux
-- -- i tested it only on windows
-- local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h')
-- 
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")
-- 
-- lspconfig.lua_ls.setup {
-- 	cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" };
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = 'LuaJIT',
-- 				path = runtime_path,
-- 			},
-- 			diagnostics = {
-- 				globals = { 'vim' },
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- }
lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
lspconfig.cmake.setup {
	init_options = {
		buildDirectory = '.cmakebuild'
	}
}

-- TREESITTER
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
require'treesitter-context'.setup{
	enable = true,
	patterns = {
		default = {
			'class',
			'function',
			'method'
		}
	}
}

-- SNIPPETS AND NVIM-CMP
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<C-l>'] = function(fallback)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		['<C-j>'] = function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}

-- NVIM TREE
require 'nvim-tree'.setup
{
	hijack_netrw = false,
	git = {
		enable = false
	},
	actions = {
		change_dir = {
			enable = false
		}
	},
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = false
	},
	renderer = {
		indent_markers = {
			enable = true
		},
	},
	view = {
		side = 'left',
		width = 25
	}
};
-- Neovim-cmake
require('cmake').setup {
	build_dir = function()
		return vim.fn.getcwd() .. '/.cmakebuild'
	end,
	parameters_file = '.cmakebuild/neovim.json',
	configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1', '-G', 'Ninja Multi-Config' },
	build_args = { '-j6' },
	copy_compile_commands = false
}

-- NVIM TABS

require("toggleterm").setup {
	float_opts = {
		border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
	},
	open_mapping = '<c-t>',
	direction = 'float',
	persist_mode = false -- start always in insert mode
}
require('nvim-autopairs').setup {
	fast_wrap = {
		chars = { '<','{', '[', '(', '"', "'" },
		map = '<M-e>',
		end_key = ')'
	}
}

-- susybaka
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

require 'dressing'.setup
{
	winblend = 0
}
require 'bufferline'.setup {
	options = {
		mode = 'tabs',
	}
}
-- DASHBOARD
require 'dashboard'.setup {
	theme = 'hyper',
	config = {
		header = {
'⠀⢠⠀⠀⢀⠲⢢⠜⡠⢒⢦⡱⣐⠂⣖⢲⣆⠲⢲⡐⢲⡒⢶⡐⢆⢠⠄⣠⢄⢢⡠⢔⢢⡒⠤⢰⠄⣦⣄⢦',
'⠤⢒⠀⣀⢠⠦⡀⢎⡰⣃⣆⠱⣈⡸⣌⠶⡈⣍⡱⢎⡱⢙⠦⣝⡨⢁⠖⣠⠎⢣⠼⢬⠧⡍⠰⣸⠄⡧⠤⠬',
'⠀⠀⠘⣡⠎⡰⠐⣪⢵⡋⣼⣳⣼⣳⢯⡿⣝⣮⡝⢎⠷⣈⢒⡤⡓⡞⣎⢅⡺⢄⠚⡌⠓⡌⡐⠀⠈⡄⠦⠄',
'⡍⣓⠲⢄⠢⣀⠷⣩⢷⣲⢯⣷⣯⣿⢿⣽⢺⡵⣂⡼⣛⢦⠣⡜⢱⣉⠖⣮⠳⢆⠓⡌⠣⠄⠡⠆⠁⠐⠀⠁',
'⡜⢌⠒⡁⠢⢉⠉⠉⡑⠫⣟⣾⣟⣾⣻⢎⡷⣹⠧⠻⠝⢬⡓⡜⣦⢉⠲⢨⠛⠎⠓⡌⠁⠀⠠⠀⠀⠀⠄⠀',
'⡜⢄⠃⢀⠲⣃⠀⠂⠀⢀⣿⣳⢯⡷⣯⢟⡳⠁⠀⠒⠀⠀⠀⣨⢄⡁⢊⠱⣌⠢⡉⠰⠀⠂⠐⠀⠀⡈⡄⠀',
'⡞⢠⠛⠃⡴⣩⢏⡿⣽⢯⡷⣯⢿⡹⣽⢻⣶⣲⣤⢦⣤⡴⣞⡵⢪⠙⠀⠐⠂⠱⠐⡀⠁⠈⠀⡁⢀⠠⠀⡀',
'⢘⠢⠐⡘⢖⢯⡞⣽⢯⣟⡽⡣⠏⠵⣫⣟⡾⣵⢫⠾⣵⣛⡞⣔⢣⠚⡴⢡⠀⠀⠁⠐⠀⡆⢀⠀⠠⢢⢙⢾',
'⢢⢍⡒⠈⡜⢌⡻⣞⡿⣾⣱⢳⣞⣽⢳⢯⠷⣭⢏⡟⣶⡹⣞⡵⢎⡻⢔⡣⡜⢡⠂⣠⠝⡼⡀⣌⠐⡠⠡⢎',
'⢣⢎⠰⡁⠠⢈⡕⢯⡟⣧⠓⠫⢞⡼⣫⢟⡻⣜⢯⢾⣱⢻⡼⣹⢞⡴⣣⠴⣢⢥⢞⣥⣻⣵⢫⡴⡘⠤⡈⢧',
'⢎⠬⡑⡔⠀⢣⡚⣥⢛⡔⣂⠀⠀⠈⠑⠫⢷⡹⣎⠷⣭⢳⡝⣧⢻⡜⣧⢻⡵⣫⣞⣾⣳⢯⣷⢯⣝⢧⡳⣌',
'⢎⡲⡑⠬⡁⢦⡙⢦⢫⡜⡰⢀⠀⠀⠀⠀⡀⠠⢍⣞⡱⣋⠾⣜⢧⡻⣜⣧⣟⣷⢿⣾⡽⣿⣽⢿⣞⣯⣟⣮',
'⢢⠱⣌⠱⡌⢂⡙⢎⠳⡜⣱⢊⠖⣀⠂⡔⠠⢘⡲⢬⠳⣭⢻⡜⣣⣝⣾⣳⡿⣾⣻⣽⢿⣟⣾⢿⣯⡿⣾⣻',
'⣈⡓⣌⠒⡜⡰⢈⠌⡳⢜⡡⢎⡱⢂⡗⡌⠄⡣⢞⢥⠻⣜⣣⢞⣷⣻⣾⡽⣟⣷⣻⣽⣟⣯⡿⣟⣾⣽⣟⣿',
'⠰⡜⣄⠫⢔⠢⣁⠎⡔⢣⠜⢢⡐⢣⠞⡈⠰⢁⢫⡼⣹⢮⣷⣟⣾⣷⣻⣟⣯⡷⣿⣳⣿⣽⣿⣻⣽⢾⣯⣿',
'⡘⡜⢤⢋⢆⠱⢄⠊⣜⢣⢛⠦⣌⣄⡳⣴⡶⣾⣳⣿⣻⡿⣞⣯⣷⣻⢷⣯⢷⣿⣻⣽⢾⣻⡾⣟⡾⣯⣷⣻',
'⡘⡜⢦⡉⢎⠜⢢⠑⢬⢣⣏⢾⣣⢿⡽⣷⢿⣳⣿⣳⣿⣻⣟⣷⣯⢿⣟⣾⣻⢷⡿⣽⣟⡷⣿⣽⣟⣯⡷⣿',
'⡘⡜⣢⡙⡌⢎⡡⢊⠜⣣⠞⣧⣟⣯⣟⣯⡿⣯⡷⣿⣳⡿⣽⡾⣽⣻⣞⡷⣯⢿⡽⣷⢯⣿⡽⣾⣻⢷⣻⣽',
'⡘⡥⡓⡜⡘⢆⠥⢃⠜⡰⣛⢶⣻⢾⣽⣳⡿⣯⣟⣷⣻⣽⣳⣟⣷⣻⣞⣿⣻⢯⣟⣿⣻⣞⣿⣳⣯⢿⣯⡿',
		},
		packages = { enable = true },
	},
	shortcut_type = 'letter',
	hide = {
		statusline = true,
		tabline = true,
		winbar = true,
	}
}
