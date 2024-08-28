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
		on_qf = function(bufnr)
			vim.keymap.set("n", "q", require("quicker").close)
		end,
	},
}
