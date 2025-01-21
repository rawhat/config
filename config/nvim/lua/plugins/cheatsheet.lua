return {
	"doctorfree/cheatsheet.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>cs", desc = "Keybind cheat sheet", "<cmd>Cheatsheet<cr>" },
	},
	config = function()
		require("cheatsheet").setup()
	end,
}
