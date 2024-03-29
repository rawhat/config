return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
		"hrsh7th/nvim-cmp",
	},
	cond = function()
		return vim.fn.exists("g:fvim_loaded") == 0
	end,
	event = "VimEnter",
	keys = {
		{ "<leader>ds", desc = "Dismiss noice notifications", "<cmd>Noice dismiss<cr>" },
	},
	config = function()
		require("noice").setup({
			lsp = {
				hover = {
					enabled = true,
				},
				signature = {
					enabled = true,
				},
				message = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
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
				mini = {
					size = { height = "auto", width = "auto", max_height = 5 },
				},
			},
		})
	end,
}
