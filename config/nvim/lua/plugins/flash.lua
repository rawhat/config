return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"s",
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
}
