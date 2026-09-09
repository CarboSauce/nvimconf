function setupLspConfigs()
	--local lspconfig = require 'lspconfig'
	local util = require 'lspconfig.util'
	local path = require 'plenary.path'

	function lspConfig(server, config) 
		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end

	vim.diagnostic.config {
		virtual_text = false,
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = false
	}
	
	-- if vim.g.use_clangd then
	lspConfig('clangd', {
		cmd = {
			"clangd",
			"--completion-style=detailed",
			"--header-insertion=never",
			"--header-insertion-decorators",
			"--all-scopes-completion",
			"--background-index", "--clang-tidy",
			"--enable-config", "--experimental-modules-support"
		},
	})
    vim.lsp.enable('mesonlsp')
    vim.lsp.enable('neocmake')
	-- RUST ANALYZER
	lspConfig('rust_analyzer', {
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
	})

	-- TYPESCRIPT
	lspConfig('ts_ls', {})

	lspConfig('emmylua_ls', {
		cmd = {'emmylua_ls'},
		filetypes = { 'lua' },
		root_markers = { {'.emmyrc.json', '.luarc.json' }, '.git' },
		settings = {
			emmylua = {
				diagnostics = {
					enable = true,
					globals = { 'vim' }
				},
				runtime = {
					version = 'LuaJIT'
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("",true),
					checkThirdParty = false
				}
			},
		}
	})
	
end

return {
	'neovim/nvim-lspconfig',
	config = setupLspConfigs
}
