return {
	'j-hui/fidget.nvim',
	version = 'v1.3.0',
	config = function()
		require 'fidget'.setup {
			notification = {
				window = {
					normal_hl = "Normal",
					winblend = 0
				}
			}
		}
	end
}
