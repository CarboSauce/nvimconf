
return {
	'nvim-lualine/lualine.nvim',
	dependencies = {'kyazdani42/nvim-web-devicons'},
	config = function()
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
	end

}
