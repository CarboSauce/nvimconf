-- General configs
local default_conf = { noremap = true, silent = true };

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
	ccls_cache_dir = ""
else
	ccls_cache_dir = "/tmp/ccls/"
end

local has_ccls = vim.fn.exepath('ccls')
if has_ccls then
	lspconfig.clangd.setup {
	cmd = {
		"clangd","--compile-commands-dir=./.cmakebuild",
		"--background-index", "--clang-tidy",
		"--completion-style=detailed"
	},
	capabilities = capabs,
	root_dir = function()
		return vim.fn.getcwd()
	end
	}
else
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

require("toggleterm").setup{
	float_opts = {
		border = {"╔", "═" ,"╗", "║", "╝", "═", "╚", "║"}
	},
	open_mapping = '<c-t>',
	direction = 'float'
}
require('nvim-autopairs').setup{
	fast_wrap = {
		chars = { '{','[','(','"',"'" },
		map = '<M-(>',
		end_key = ')'
	}
}
require('telescope').setup{}
-- SUMNEKO LSP
-- reference: https://jdhao.github.io/2021/08/12/nvim_sumneko_lua_conf/
local sumneko_binary_path = vim.fn.exepath('lua-language-server')
-- TODO: Idk if :h paremeter is enough to make stuff work on linux
-- i tested it only on windows
local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
        runtime = {
            version = 'LuaJIT',
            path = runtime_path,
        },
        diagnostics = {
            globals = {'vim'},
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

require'dressing'.setup{}
require'bufferline'.setup {
	options = {
		mode = 'buffers',
	}
}
-- DASHBOARD
local db = require'dashboard'
db.preview_file_height = 12
db.session_directory = os.getenv("TMP")
db.preview_file_width = 80
db.hide_tabline = false
db.custom_header = {
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝'
}
db.custom_center = {
     {icon = '  ',
      desc = 'Recently latest session                  ',
      shortcut = 'SPC s l',
      action ='SessionLoad'},
      {icon = '  ',
      desc = 'Recently opened files                   ',
      action =  'DashboardFindHistory',
      shortcut = 'SPC f h'},
      {icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f'},
      {icon = '  ',
      desc ='File Browser                            ',
      action =  'Telescope file_browser',
      shortcut = 'SPC f b'},
}
