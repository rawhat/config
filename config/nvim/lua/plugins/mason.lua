return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	keys = {
		{ "<leader>li", desc = "Open mason", "<cmd>Mason<cr>" },
	},
	config = function()
		require("mason").setup()
	end,
}
