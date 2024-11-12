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
