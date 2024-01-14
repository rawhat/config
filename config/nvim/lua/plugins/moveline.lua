return {
	"willothy/moveline.nvim",
	build = "make",
	keys = {
		{
			"<C-k>",
			mode = { "v" },
			desc = "Move selection up",
			function()
				require("moveline").block_up()
			end,
		},
		{
			"<C-j>",
			mode = { "v" },
			desc = "Move selection down",
			function()
				require("moveline").block_down()
			end,
		},
	},
}
