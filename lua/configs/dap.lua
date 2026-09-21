return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'Civitasv/cmake-tools.nvim'
        },
        config = function ()
            local dap = require 'dap'

            dap.adapters.lldb = { type = 'executable', command = 'lldb-dap', name = 'lldb' }

            dap.adapters.gdb = {
                type = 'executable',
                command = 'gdb',
                name = 'gdb',
                args = {
                    '--interpreter=dap'
                }
            }

            dap.configurations.cpp = {
                {
                    name = 'Launch gdb',
                    type = 'gdb',
                    request = 'launch',
                    program = function ()
                        return vim.fn.input('Path to executable', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {}
                },
                {
                    name = 'Launch lldb',
                    type = 'lldb',
                    request = 'launch',
                    program = function ()
                        return vim.fn.input('Path to executable', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {}
                }
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.ruts = dap.configurations.cpp

            dap.adapters.cmake = function (callback, _config)
                local cmake = require 'cmake-tools'
                local build = tostring(cmake.get_build_directory())
                local options = tostring(cmake.get_generate_options())
                callback {
                    type = 'pipe',
                    pipe = '${pipe}',
                    executable = {
                        command = "sh",
                        args = {
                            "-c",
                            string.format("cmake --debugger --debugger-pipe=${pipe} -B %s %s", build, options)
                        }
                    }
                }
            end

            dap.configurations.cmake = {
                {
                    name = 'Debug CMake',
                    type = 'cmake',
                    request = 'launch',
                    program = '${file}'
                }
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        opts = {},
        keys = {
            {
                '<leader>du',
                function () require 'dapui'.toggle() end,
                desc = "Toggle DAP UI"
            }
        }
    }
}
