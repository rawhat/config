return {
	{
		"folke/trouble.nvim",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "LSP diagnostics" },
			--[[ { "gr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references" },
			{ "gd", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "LSP definitions" },
			{ "gD", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "LSP type definitions" },
			{ "gm", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "LSP implementations" }, ]]
		},
		opts = {
			focus = true,
			follow = false,
			auto_close = true,
			auto_jump = true,
			modes = {
				diagnostics = {
					auto_jump = false,
					focus = true,
					groups = {
						{ "filename", format = "{file_icon} {basename} {count}" },
					},
				},
			},
		},
		specs = {
			"folke/snacks.nvim",
			opts = function(_, opts)
				return vim.tbl_deep_extend("force", opts or {}, {
					picker = {
						actions = require("trouble.sources.snacks").actions,
						win = {
							input = {
								keys = {
									["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
								},
							},
						},
					},
				})
			end,
		},
	},
}
