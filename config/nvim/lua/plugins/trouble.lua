local theme = require("themes").current_theme

return {
	"folke/trouble.nvim",
	dependencies = { theme.package },
	keys = {
		{ "<leader>xx", desc = "Toggle Trouble", "<cmd>TroubleToggle<cr>" },
	},
	config = function()
		require("trouble").setup()
	end,
}
