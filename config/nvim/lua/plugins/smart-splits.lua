return {
	"mrjones2014/smart-splits.nvim",
	keys = {
		{
			"<C-l>",
			desc = "Resize right",
			function()
				require("smart-splits").resize_right()
			end,
		},
		{
			"<C-k>",
			desc = "Resize up",
			function()
				require("smart-splits").resize_up()
			end,
		},
		{
			"<C-j>",
			desc = "Resize down",
			function()
				require("smart-splits").resize_down()
			end,
		},
		{
			"<C-h>",
			desc = "Resize left",
			function()
				require("smart-splits").resize_left()
			end,
		},
	},
}
