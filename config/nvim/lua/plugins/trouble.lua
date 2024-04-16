return {
	{
		"folke/trouble.nvim",
		branch = "dev",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "LSP diagnostics" },
			{ "<leader>qo", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix toggle" },
			{ "gr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references" },
			{ "gd", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "LSP definitions" },
			{ "gD", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "LSP type definitions" },
			{ "gm", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "LSP implementations" },
		},
		config = function()
			require("trouble").setup({
				focus = true,
				follow = false,
				results = {
					auto_close = true,
				},
			})
		end,
	},
}
