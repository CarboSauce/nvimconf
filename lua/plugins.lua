local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--depth=1",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "configs" },
    { 'lunacookies/vim-colors-xcode' },
    { 'nyoom-engineering/oxocarbon.nvim', build = false },
    { 'RRethy/nvim-base16' },
    { 'LunarVim/horizon.nvim' },
    -- plugins
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
                "<leader>J",
                "<cmd>TSJToggle<cr>",
                desc = "Join Toggle"
            }
        },
        opts = {
            use_default_keymaps = false,
            max_join_length = 150
        }
    },
    {
        'windwp/nvim-autopairs',
        opts = {
            fast_wrap = {
                map = '<esc>e',
                chars = { '<', '{', '[', '(', '"', "'" },
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
                    hijack_netrw = false
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
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function ()
            local get_option = vim.filetype.get_option
            vim.filetype.get_option = function (filetype, option)
                return option == "commentstring"
                    and require("ts_context_commentstring.internal").calculate_commentstring()
                    or get_option(filetype, option)
            end
            vim.g.skip_ts_context_commentstring_module = true
            require('ts_context_commentstring').setup { enable_autocmd = false }
        end
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
    {
        'windwp/nvim-ts-autotag',
        config = function ()
            require 'nvim-ts-autotag'.setup({})
        end
    },
    {
        'stevearc/oil.nvim',
        config = function ()
            require 'oil'.setup()
        end
    },
    {
        'MagicDuck/grug-far.nvim',
        config = function ()
            require 'grug-far'.setup({})
        end
    },
    {
        'neogitorg/neogit',
        lazy = true,
        cmd = "Neogit",
        dependencies = {
            'sindrets/diffview.nvim'
        },
        keys = {
            { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' }
        }
    },
    {
        'marc0x71/mesone.nvim',
        lazy = true,
        cmd = 'Mesone',
        opts = {
            build_folder = 'build',
            build_type = 'debugoptimized',
            dap_adapter = 'gdb',
            show_command_logs = false,
            auto_compile = true,
            auto_close_terminal = false,
            compile_before_run = false
        }
    },
    {
        'Civitasv/cmake-tools.nvim',
        opts = {
            cmake_build_options = {
                '--parallel',
                '--verbose'
            },
            cmake_generate_options = {
                '-DCMAKE_GENERATOR=Ninja',
                '-DCMAKE_EXPORT_COMPILE_COMMANDS=1'
            },
            cmake_build_directory = "build/${kit}/${kitGenerator}/${variant:buildType}",
            cmake_dap_configuration = {
                name = 'cpp',
                type = 'gdb',
                request = 'launch',
                stopOnEntry = false,
                runInTerminal = true,
                console = 'integratedTerminal'
            }
        }
    }
},
    {
        change_detection = {
            enabled = false
        }
    })
