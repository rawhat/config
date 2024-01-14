return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			trouble = true,
		})
	end,
}
