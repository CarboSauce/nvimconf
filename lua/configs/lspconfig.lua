function setupLspConfigs()
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

	--capabs.textDocument.completion.completionItem.snippetSupport=true
	lspconfig.emmet_ls.setup{
	}
	lspconfig.angularls.setup{}

	-- lspconfig.asm_lsp.setup{}

	-- if vim.g.use_clangd then
	lspconfig.clangd.setup {
		cmd = {
			"clangd", 
			"--compile-commands-dir=./build",
			"--completion-style=detailed",
			"--header-insertion=never",
			"--header-insertion-decorators",
			"--all-scopes-completion",
			"--background-index", "--clang-tidy",
			"--enable-config"
		},
		capabilities = capabs,
		on_attach = on_attach,
		root_dir = cxx_root_dir
	}
	-- else
	-- 	lspconfig.ccls.setup {
	-- 		init_options = {
	-- 			cache = {
	-- 				directory = ".cmakebuild/ccls"
	-- 			},
	-- 			compilationDatabaseDirectory = ".cmakebuild",
	-- 			completion = {
	-- 				placeholder = false
	-- 			},
	-- 			highlight = {
	-- 				lsRanges = true
	-- 			},
	-- 		},
	-- 		root_dir = cxx_root_dir,
	-- 		capabilities = capabs,
	-- 		single_file_support = true
	-- 	}
	-- end
	-- RUST ANALYZER
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

	-- TYPESCRIPT
	lspconfig.tsserver.setup {}

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
end

return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'Issafalcon/lsp-overloads.nvim'
	},
	config = setupLspConfigs
}
