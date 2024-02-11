return {
	'rcarriga/nvim-notify',
	config = function()
		require('notify').setup {
			background_colour = "#000000",
			icons = {
			  DEBUG = "",
			  ERROR = "",
			  INFO = "",
			  TRACE = "✎",
			  WARN = ""
			},
			level = 2,
			minimum_width = 50,
			render = "simple",
			stages = "fade",
			time_formats = {
			  notification = "%T",
			  notification_history = "%FT%T"
			},
			timeout = 3000,
			top_down = true
		}
		vim.notify = require ('notify')
	end


}
