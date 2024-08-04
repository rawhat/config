return {
	"stevearc/oil.nvim",
	event = "VimEnter",
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
				["<Esc>"] = "actions.close",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-h>"] = false,
				["<C-t>"] = false,
				["<C-q>"] = "actions.send_to_qflist",
			},
		})
	end,
}
