return {
	'nvim-tree/nvim-tree.lua',
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	lazy = true,
	cmd = 'NvimTreeToggle',
	config = function()
		require 'nvim-tree'.setup {
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
	end
}
