return {
	"sindrets/diffview.nvim",
	keys = {
		{ "<leader>do", desc = "Open diffview against develop", "<cmd>DiffviewOpen origin/develop<cr>" },
		{ "<leader>dv", desc = "Open diffview against HEAD", "<cmd>DiffviewOpen<cr>" },
		{
			"<leader>db",
			desc = "Open diffview against branch",
			function()
				vim.ui.input({ prompt = "Branch to diff against" }, function(search)
					vim.cmd.DiffviewOpen(search)
				end)
			end,
		},
		{ "<leader>dc", desc = "Close diffview", "<cmd>DiffviewClose<cr>" },
		{ "<leader>df", desc = "Toggle diffview file panel", "<cmd>DiffviewToggleFiles<cr>" },
	},
	opts = {
		default_args = {
			DiffviewOpen = { "--imply-local" },
		},
	},
}
