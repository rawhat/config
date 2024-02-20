return {
	"DNLHC/glance.nvim",
	event = "BufEnter",
	keys = {
		{ "<leader>lr", desc = "LSP references", "<cmd>Glance references<cr>" },
		{ "<leader>lf", desc = "LSP definitions", "<cmd>Glance definitions<cr>" },
		{ "<leader>lt", desc = "LSP type definitions", "<cmd>Glance type_definitions<cr>" },
		{ "<leader>lm", desc = "LSP implementations", "<cmd>Glance implementations<cr>" },
	},
	opts = {},
}
