return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	cond = function()
		return vim.fn.exists("g:fvim_loaded") == 0
	end,
	event = "VimEnter",
	opts = {
		lsp = {
			hover = {
				enabled = true,
			},
			message = {
				enabled = true,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
			},
		},
		presets = {
			bottom_search = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
		routes = {
			{ filter = { event = "msg_show", find = "search hit BOTTOM" }, skip = true },
			{ filter = { event = "msg_show", find = "search hit TOP" }, skip = true },
			{ filter = { event = "msg_show", find = "No signature help" }, skip = true },
		},
		views = {
			cmdline_popup = {
				position = {
					row = 5,
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			mini = {
				size = { height = "auto", width = "auto", max_height = 5 },
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = 8,
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
			},
		},
	},
}
