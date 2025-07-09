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
		{
			"<leader>qd",
			desc = "Open diagnostics in quickfix",
			function()
				vim.diagnostic.setqflist()
			end,
		},
	},
	opts = {
		keys = {
			{
				">",
				function()
					require("quicker").toggle_expand()
				end,
				desc = "Expand quickfix content",
			},
		},
		follow = { enabled = true },
		on_qf = function()
			vim.keymap.set("n", "q", function()
				require("quicker").close()
			end)
		end,
	},
}
