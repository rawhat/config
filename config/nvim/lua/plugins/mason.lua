return {
	"mason-org/mason.nvim",
	dependencies = { "mason-org/mason-lspconfig.nvim" },
	keys = {
		{ "<leader>li", desc = "Open mason", "<cmd>Mason<cr>" },
	},
	config = function()
		require("mason").setup()
	end,
}
