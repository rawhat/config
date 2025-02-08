return {
	"stevearc/quicker.nvim",
	event = "Filetype qf",
	keys = {
		{
			"<leader>qo",
			desc = "Toggle quickfix window",
			function()
				require("quicker").toggle({ focus = true })
			end,
		},
	},
	opts = {
		keys = {
			{
				">",
				"<cmd>lua require('quicker').toggle_expand()<cr>",
				desc = "Expand quickfix content",
			},
		},
		on_qf = function(bufnr)
			vim.keymap.set("n", "q", require("quicker").close)
		end,
	},
}
