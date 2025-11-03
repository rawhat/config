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
			"<leader>ds",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss notifications",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
		},
		{
			"<leader>gl",
			desc = "Find in jumplist",
			function()
				Snacks.picker.jumps()
			end,
		},
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
			"<leader>se",
			desc = "Find in git diff files",
			function()
				Snacks.picker.git_status()
			end,
		},
		{
			"<leader>sf",
			desc = "Search files",
			function()
				Snacks.picker.smart({ show_delay = 100 })
			end,
		},
		{
			"<leader>sg",
			desc = "Find config files",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
		},
		{
			"<leader>sh",
			desc = "Search help Tags",
			function()
				Snacks.picker.help()
			end,
		},
		{
			"<leader>sj",
			desc = "Search projects",
			function()
				Snacks.picker.projects({
					confirm = function(picker, item)
						require("snacks.picker.actions").load_session(picker, item)
						local bufs = vim.api.nvim_list_bufs()
						local wins = vim.api.nvim_list_wins()
						for _, win in pairs(wins) do
							if vim.w[win].snacks_win ~= nil then
								bufs = vim.tbl_filter(function(b)
									return b ~= vim.api.nvim_win_get_buf(win)
								end, bufs)
							end
						end
						for _, buf in pairs(bufs) do
							vim.api.nvim_buf_delete(buf, {})
						end
					end,
				})
			end,
		},
		{
			"<leader>sk",
			desc = "Search keymaps",
			function()
				Snacks.picker.keymaps()
			end,
		},
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
			"<leader>sn",
			desc = "Search notifications",
			function()
				Snacks.picker.notifications()
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
			"<leader>sp",
			desc = "Search ViM Options",
			function()
				Snacks.picker.man()
			end,
		},
		{
			"<leader>ss",
			desc = "Search LSP symbols",
			function()
				Snacks.picker.lsp_symbols()
			end,
		},
		{
			"<leader>sw",
			desc = "Search highlighted word",
			function()
				Snacks.picker.grep_word({ show_delay = 100 })
			end,
			mode = { "v" },
		},
		{
			"<leader>sw",
			desc = "Search word",
			function()
				Snacks.picker.grep({ show_delay = 100 })
			end,
		},
		{
			"<leader>tr",
			desc = "Open terminal to the right",
			function()
				Snacks.terminal.open(nil, { win = { position = "right" } })
			end,
		},
		{
			"<leader>to",
			desc = "Open terminal to the bottom",
			function()
				Snacks.terminal.open(nil, { win = { position = "bottom" } })
			end,
		},
		{
			"<leader>tt",
			desc = "Toggle terminal",
			function()
				Snacks.terminal.toggle()
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
			"gd",
			desc = "LSP definitions",
			function()
				Snacks.picker.lsp_definitions()
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
			"gr",
			desc = "LSP references",
			function()
				Snacks.picker.lsp_references()
			end,
		},
		{
			"gl",
			desc = "LSP declarations",
			function()
				Snacks.picker.lsp_declarations()
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
			},
			scope = {
				enabled = true,
				hl = "IndentBlanklineContextChar",
			},
		},
		input = {
			enabled = true,
		},
		notifier = { enabled = true },
		notify = { enabled = true },
		picker = {
			formatters = {
				file = {
					truncate = 80,
				},
			},
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
