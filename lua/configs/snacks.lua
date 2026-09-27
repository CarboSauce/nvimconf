return {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    win = {
                        list = {
                            keys = {
                                ["A"] = "explorer_add_dotnet"
                            }
                        }
                    },
                    actions = {
                        explorer_add_dotnet = function (picker)
                            local dir = picker:dir()
                            require 'easy-dotnet'.create_item(dir)
                        end
                    }
                }
            }
        },
        bufdelete = {
            enabled = true
        },
        notifier = {
            style = 'compact'
        },
        explorer = {},
        dashboard = {
            enabled = true,
            preset = {
                header = [[
⠀⢠⠀⠀⢀⠲⢢⠜⡠⢒⢦⡱⣐⠂⣖⢲⣆⠲⢲⡐⢲⡒⢶⡐⢆⢠⠄⣠⢄⢢⡠⢔⢢⡒⠤⢰⠄⣦⣄⢦
⠤⢒⠀⣀⢠⠦⡀⢎⡰⣃⣆⠱⣈⡸⣌⠶⡈⣍⡱⢎⡱⢙⠦⣝⡨⢁⠖⣠⠎⢣⠼⢬⠧⡍⠰⣸⠄⡧⠤⠬
⠀⠀⠘⣡⠎⡰⠐⣪⢵⡋⣼⣳⣼⣳⢯⡿⣝⣮⡝⢎⠷⣈⢒⡤⡓⡞⣎⢅⡺⢄⠚⡌⠓⡌⡐⠀⠈⡄⠦⠄
⡍⣓⠲⢄⠢⣀⠷⣩⢷⣲⢯⣷⣯⣿⢿⣽⢺⡵⣂⡼⣛⢦⠣⡜⢱⣉⠖⣮⠳⢆⠓⡌⠣⠄⠡⠆⠁⠐⠀⠁
⡜⢌⠒⡁⠢⢉⠉⠉⡑⠫⣟⣾⣟⣾⣻⢎⡷⣹⠧⠻⠝⢬⡓⡜⣦⢉⠲⢨⠛⠎⠓⡌⠁⠀⠠⠀⠀⠀⠄⠀
⡜⢄⠃⢀⠲⣃⠀⠂⠀⢀⣿⣳⢯⡷⣯⢟⡳⠁⠀⠒⠀⠀⠀⣨⢄⡁⢊⠱⣌⠢⡉⠰⠀⠂⠐⠀⠀⡈⡄⠀
⡞⢠⠛⠃⡴⣩⢏⡿⣽⢯⡷⣯⢿⡹⣽⢻⣶⣲⣤⢦⣤⡴⣞⡵⢪⠙⠀⠐⠂⠱⠐⡀⠁⠈⠀⡁⢀⠠⠀⡀
⢘⠢⠐⡘⢖⢯⡞⣽⢯⣟⡽⡣⠏⠵⣫⣟⡾⣵⢫⠾⣵⣛⡞⣔⢣⠚⡴⢡⠀⠀⠁⠐⠀⡆⢀⠀⠠⢢⢙⢾
⢢⢍⡒⠈⡜⢌⡻⣞⡿⣾⣱⢳⣞⣽⢳⢯⠷⣭⢏⡟⣶⡹⣞⡵⢎⡻⢔⡣⡜⢡⠂⣠⠝⡼⡀⣌⠐⡠⠡⢎
⢣⢎⠰⡁⠠⢈⡕⢯⡟⣧⠓⠫⢞⡼⣫⢟⡻⣜⢯⢾⣱⢻⡼⣹⢞⡴⣣⠴⣢⢥⢞⣥⣻⣵⢫⡴⡘⠤⡈⢧
⢎⠬⡑⡔⠀⢣⡚⣥⢛⡔⣂⠀⠀⠈⠑⠫⢷⡹⣎⠷⣭⢳⡝⣧⢻⡜⣧⢻⡵⣫⣞⣾⣳⢯⣷⢯⣝⢧⡳⣌
⢎⡲⡑⠬⡁⢦⡙⢦⢫⡜⡰⢀⠀⠀⠀⠀⡀⠠⢍⣞⡱⣋⠾⣜⢧⡻⣜⣧⣟⣷⢿⣾⡽⣿⣽⢿⣞⣯⣟⣮
⢢⠱⣌⠱⡌⢂⡙⢎⠳⡜⣱⢊⠖⣀⠂⡔⠠⢘⡲⢬⠳⣭⢻⡜⣣⣝⣾⣳⡿⣾⣻⣽⢿⣟⣾⢿⣯⡿⣾⣻
⣈⡓⣌⠒⡜⡰⢈⠌⡳⢜⡡⢎⡱⢂⡗⡌⠄⡣⢞⢥⠻⣜⣣⢞⣷⣻⣾⡽⣟⣷⣻⣽⣟⣯⡿⣟⣾⣽⣟⣿
⠰⡜⣄⠫⢔⠢⣁⠎⡔⢣⠜⢢⡐⢣⠞⡈⠰⢁⢫⡼⣹⢮⣷⣟⣾⣷⣻⣟⣯⡷⣿⣳⣿⣽⣿⣻⣽⢾⣯⣿
⡘⡜⢤⢋⢆⠱⢄⠊⣜⢣⢛⠦⣌⣄⡳⣴⡶⣾⣳⣿⣻⡿⣞⣯⣷⣻⢷⣯⢷⣿⣻⣽⢾⣻⡾⣟⡾⣯⣷⣻
⡘⡜⢦⡉⢎⠜⢢⠑⢬⢣⣏⢾⣣⢿⡽⣷⢿⣳⣿⣳⣿⣻⣟⣷⣯⢿⣟⣾⣻⢷⡿⣽⣟⡷⣿⣽⣟⣯⡷⣿
⡘⡜⣢⡙⡌⢎⡡⢊⠜⣣⠞⣧⣟⣯⣟⣯⡿⣯⡷⣿⣳⡿⣽⡾⣽⣻⣞⡷⣯⢿⡽⣷⢯⣿⡽⣾⣻⢷⣻⣽
⡘⡥⡓⡜⡘⢆⠥⢃⠜⡰⣛⢶⣻⢾⣽⣳⡿⣯⣟⣷⣻⣽⣳⣟⣷⣻⣞⣿⣻⢯⣟⣿⣻⣞⣿⣳⣯⢿⣯⡿]]
            },
            sections = {
                { section = "header" },
                { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" }
            }
        }
    }
}
