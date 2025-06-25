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
		{
			"<leader>dr",
			desc = "Open diffview against ref",
			function()
				vim.ui.input({ prompt = "Enter a git ref to diff against" }, function(input)
					if input then
						vim.cmd.DiffviewOpen(input)
					end
				end)
			end,
		},
		{ "<leader>dh", desc = "Show git history for currenty file", "<cmd>DiffviewFileHistory %<cr>" },
	},
	opts = {
		default_args = {
			DiffviewOpen = { "--imply-local" },
		},
	},
}
