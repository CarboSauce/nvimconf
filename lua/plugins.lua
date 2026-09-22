local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." }
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "configs" },
        { 'lunacookies/vim-colors-xcode' },
        { 'nyoom-engineering/oxocarbon.nvim', build = false },
        { 'RRethy/nvim-base16' },
        {
            'scottmckendry/cyberdream.nvim',
            lazy = false,
            priority = 1000,
            opts = {
                variant = 'muted',
                transparent = true
            }
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
            opts = {}
        },
        {
            'stevearc/oil.nvim',
            opts = {}
        },
        {
            'MagicDuck/grug-far.nvim',
            opts = {}
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
    install = {
        missing = true,
        colorscheme = {
            'cyberdream'
        }
    }
})
