return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = { "BufEnter" },
		keys = {
			{
				"zR",
				desc = "Open all folds",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				desc = "Close all folds",
				function()
					require("ufo").closeAllFolds()
				end,
			},
		},
		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},
	},
}
