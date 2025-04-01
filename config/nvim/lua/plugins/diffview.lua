return {
	"sindrets/diffview.nvim",
	keys = {
		{ "<leader>do", desc = "Open diffview against develop", "<cmd>DiffviewOpen origin/develop<cr>" },
		{ "<leader>dv", desc = "Open diffview against HEAD", "<cmd>DiffviewOpen<cr>" },
		{
			"<leader>db",
			desc = "Open diffview against branch",
			function()
				local output = vim.system({ "git", "branch", "-a" }, { text = true }):wait()
				local branches = vim.split(output.stdout, "\n")
				vim.ui.select(branches, { prompt = "Select branch to diff against" }, function(item)
					if item ~= nil then
						vim.cmd.DiffviewOpen(item)
					end
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
