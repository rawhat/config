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
		{
			"<leader>se",
			desc = "Find in git diff files",
			function()
				Snacks.picker.git_status()
			end,
		},
		{
			"<leader>gl",
			desc = "Find in jumplist",
			function()
				Snacks.picker.jumps()
			end,
		},
		-- { "<leader>lp", desc = "List previous pickers", "<cmd>Telescope pickers<cr>" },
		{
			"<leader>rp",
			desc = "Resume previous picker",
			function()
				Snacks.picker.resume()
			end,
		},
		{
			"<leader>sb",
			desc = "Fuzzy find in buffer",
			function()
				Snacks.picker.lines()
			end,
		},
		{
			"<leader>sc",
			desc = "Search commands",
			function()
				Snacks.picker.commands()
			end,
		},
		{
			"<leader>sd",
			desc = "Search LSP diagnostics",
			function()
				Snacks.picker.diagnostics()
			end,
		},
		{
			"<leader>sf",
			desc = "Search files",
			function()
				Snacks.picker.smart()
			end,
		},
		{
			"<leader>sh",
			desc = "Search help Tags",
			function()
				Snacks.picker.help()
			end,
		},
		-- { "<leader>si", desc = "Search... search history", "<cmd>Telescope search_history<cr>" },
		{
			"<leader>sl",
			desc = "Search buffers",
			function()
				Snacks.picker.buffers()
			end,
		},
		{
			"<leader>sm",
			desc = "Search command history",
			function()
				Snacks.picker.command_history()
			end,
		},
		{
			"<leader>sp",
			desc = "Search ViM Options",
			function()
				Snacks.picker.man()
			end,
		},
		{
			"<leader>sw",
			desc = "Search word",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			"<leader>sw",
			desc = "Search highlighted word",
			function()
				Snacks.picker.grep_word()
			end,
			mode = { "v" },
		},
		{
			"<leader>sg",
			desc = "Find config files",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
		},
		{
			"<leader>so",
			desc = "Grep config files",
			function()
				Snacks.picker.grep({ dirs = { vim.fn.stdpath("config") } })
			end,
		},
		{
			"gd",
			desc = "LSP definitions",
			function()
				Snacks.picker.lsp_definitions()
			end,
		},
		{
			"gr",
			desc = "LSP references",
			function()
				Snacks.picker.lsp_references()
			end,
		},
		{
			"gD",
			desc = "LSP type definitions",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
		},
		{
			"gm",
			desc = "LSP implementations",
			function()
				Snacks.picker.lsp_implementations()
			end,
		},
		{
			"<leader>sk",
			desc = "Search keymaps",
			function()
				Snacks.picker.keymaps()
			end,
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
		picker = {
			layout = {
				reverse = true,
				layout = {
					box = "horizontal",
					backdrop = false,
					width = 0.8,
					height = 0.9,
					border = "none",
					{
						box = "vertical",
						{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
						{
							win = "input",
							height = 1,
							border = "rounded",
							title = "{source} {live}",
							title_pos = "center",
						},
					},
					{
						win = "preview",
						width = 0.45,
						border = "rounded",
						title = " Preview ",
						title_pos = "center",
					},
				},
			},
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
						["<c-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
						["<c-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
						["<c-x>"] = { "edit_split", mode = { "n", "i" } },
					},
				},
			},
		},
		quickfile = { enabled = true },
		statuscolumn = {
			left = { "sign" },
			right = { "git" },
		},
		terminal = {},
	},
}
