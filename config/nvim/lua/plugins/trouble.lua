return {
	{
		"folke/trouble.nvim",
		branch = "dev",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "LSP diagnostics" },
			{ "<leader>qo", "<cmd>Trouble qflist toggle focus=true<cr>", desc = "Quickfix toggle" },
			{ "<leader>oi", "<cmd>Trouble symbols toggle focus=true<cr>", desc = "Symbols outline" },
			{ "gr", "<cmd>Trouble lsp_references toggle focus=true<cr>", desc = "LSP references" },
			{ "gd", "<cmd>Trouble lsp_definitions toggle focus=true<cr>", desc = "LSP definitions" },
			{ "gD", "<cmd>Trouble lsp_type_definitions toggle focus=true<cr>", desc = "LSP type definitions" },
			{ "gm", "<cmd>Trouble lsp_implementations toggle focus=true<cr>", desc = "LSP implementations" },
		},
		config = function()
			require("trouble").setup({
				results = {
					auto_close = true,
				},
			})
		end,
	},
}
