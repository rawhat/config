return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete buffer",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
		{
			"<leader>ds",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss notifications",
		},
	},
	opts = {
		bigfile = { enabled = true },
		bufdelete = { enabled = true },
		-- indent = { enabled = true, indent = { only_scope = true } },
		notify = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = {
			left = { "sign" },
			right = { "git" },
		},
	},
}
