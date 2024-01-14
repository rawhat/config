return {
	"sudormrfbin/cheatsheet.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>cs", desc = "Keybind cheat sheet", "<cmd>Cheatsheet<cr>" },
	},
	config = function()
		require("cheatsheet").setup({
			["<CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
			["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
		})
	end,
}
