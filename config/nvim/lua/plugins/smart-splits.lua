return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	opts = {
		multiplexer_itegration = "wezterm",
		at_edge = "stop",
	},
	keys = {
		{
			"<A-h>",
			desc = "Move left",
			function()
				require("smart-splits").move_cursor_left()
			end,
		},
		{
			"<A-j>",
			desc = "Move down",
			function()
				require("smart-splits").move_cursor_down()
			end,
		},
		{
			"<A-k>",
			desc = "Move up",
			function()
				require("smart-splits").move_cursor_up()
			end,
		},
		{
			"<A-l>",
			desc = "Move right",
			function()
				require("smart-splits").move_cursor_right()
			end,
		},
		{
			"<C-A-l>",
			desc = "Resize right",
			function()
				require("smart-splits").resize_right()
			end,
		},
		{
			"<C-A-k>",
			desc = "Resize up",
			function()
				require("smart-splits").resize_up()
			end,
		},
		{
			"<C-A-j>",
			desc = "Resize down",
			function()
				require("smart-splits").resize_down()
			end,
		},
		{
			"<C-A-h>",
			desc = "Resize left",
			function()
				require("smart-splits").resize_left()
			end,
		},
	},
}
