return {
	"DNLHC/glance.nvim",
	event = "BufEnter",
	keys = {
		{ "gr", desc = "LSP references", "<cmd>Glance references<cr>" },
		{ "gd", desc = "LSP definitions", "<cmd>Glance definitions<cr>" },
		{ "gD", desc = "LSP type definitions", "<cmd>Glance type_definitions<cr>" },
		{ "gm", desc = "LSP implementations", "<cmd>Glance implementations<cr>" },
	},
	opts = {},
}
