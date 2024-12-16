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
		indent = {
			enabled = true,
			animate = { enabled = false },
			indent = {
				enabled = true,
				char = "│",
				-- char = "▎",
				-- only_scope = true,
			},
			scope = {
				enabled = true,
				hl = "IndentBlanklineContextChar",
			},
		},
		notifier = { enabled = true },
		notify = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = {
			left = { "sign" },
			right = { "git" },
		},
	},
}
