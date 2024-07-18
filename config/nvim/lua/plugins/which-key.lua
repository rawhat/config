local theme = require("themes").current_theme

return {
	"folke/which-key.nvim",
	dependencies = { theme.package_name },
	opts = {
		plugins = {
			presets = {
				operators = false,
			},
		},
		preset = "modern",
	},
}
