local theme = require("themes").current_theme

return {
	"folke/which-key.nvim",
	dependencies = { theme.package },
	opts = {
		key_labels = { ["<leader>"] = "<space>" },
		plugins = {
			presets = {
				operators = false,
			},
		},
	},
}
