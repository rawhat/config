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
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
}
