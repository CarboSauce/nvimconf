-- General configs
default_conf = { noremap = true, silent = true };

vim.keymap.set('n','<Leader>fmt', vim.lsp.buf.formatting,default_conf)
vim.keymap.set('n','<Leader>def',vim.lsp.buf.definition,default_conf)
vim.keymap.set('n','<Leader>rn',vim.lsp.buf.rename,default_conf)

-- LUA LINE
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'horizon',
    component_separators = { left = '│', right = '│'},
    section_separators = { left = '▌', right = '▐'},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}

}
-- LSP STUFF
local capabs = vim.lsp.protocol.make_client_capabilities()
capabs = require('cmp_nvim_lsp').update_capabilities(capabs)
local lspconfig = require('lspconfig')

-- CCLS CONFIG
if vim.fn.has('win32')
then
	local ccls_cache_dir = ""
else
	local ccls_cache_dir = "/tmp/ccls/"
end

local cxx_use_clangd = true

if cxx_use_clangd then
	lspconfig.clangd.setup {
	init_options = {
		cmd = {
			"clangd","--compile-commands-dir=.cmakebuild",
			"--background-index"
		},
	},
	capabilities = capab,
	root_dir = function()
		return vim.fn.getcwd()
	end
	}
else
	print('Using ccls')
	lspconfig.ccls.setup {
	init_options = {
		cache = {
			directory = ccls_cache_dir
		},
		compilationDatabaseDirectory = ".cmakebuild",
		completion = {
			placeholder = false
		},
		highlight = {
			lsRanges = true
		},
	},
	root_dir = function() 
		return vim.fn.getcwd()
	end,
	capabilities = capabs
	}
end

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
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
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
require'nvim-tree'.setup
{
	update_cwd = true,
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
-- CMAKE4VIM
vim.cmd([[
let g:cmake_kits = {
            \  "gcc": {
            \    "compilers": {
            \        "C": "/usr/bin/gcc",
            \        "CXX": "/usr/bin/g++"
            \  },
			\ "clang": {
			\  "compilers": {
			\   "C": "/usr/bin/clang",
			\   "CXX": "/usr/bin/clang++"
			\}}}}
let g:cmake_build_dir = ".cmakebuild"
let g:cmake_compile_commands = 1 
let g:cmake_project_generator = "Ninja"
let g:make_arguments = "-j 8"
nnoremap <leader>cc :CMake<CR>
nnoremap <leader>cb :CMakeBuild<CR>
nnoremap <leader>cr :CMakeRun<CR>
]])
-- NVIM TABS
local bufline = require 'bufferline'
local hl = require'bufferline.utils'.hl

bufline.setup {
	auto_hide = true,
	closable = true,
	clickable = true,
	icons = true,
	icon_custom_colors = false,
}
require("toggleterm").setup{
	float_opts = {
		border = {"╔", "═" ,"╗", "║", "╝", "═", "╚", "║"}
	}
}
