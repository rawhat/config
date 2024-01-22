return {
	"stevearc/oil.nvim",
	keys = {
		{
			"<C-n>",
			desc = "Oil in CWD",
			function()
				require("oil").open_float(vim.fn.expand("%:p:h"))
			end,
		},
	},
	config = function()
		require("oil").setup({
			keymaps = {
				q = "actions.close",
			},
		})
	end,
}
