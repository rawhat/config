local theme = require("themes").current_theme

return {
	"folke/which-key.nvim",
	dependencies = { theme.package },
	opts = {
		plugins = {
			presets = {
				operators = false,
			},
		},
		preset = "modern",
	},
}
