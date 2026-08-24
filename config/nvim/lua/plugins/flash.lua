return {
	"folke/flash.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<cr>",
			mode = { "n", "x", "o" },
			desc = "jump around",
			function()
				require("flash").jump()
			end,
		},
		{
			"S",
			mode = { "n", "o", "x" },
			desc = "leapin around the trees",
			function()
				require("flash").treesitter()
			end,
		},
	},
	config = function()
		require("flash").setup({})
	end,
}
