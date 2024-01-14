return {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim",
	},
	keys = {
		{ "<leader>xz", desc = "Toggle maximize current buffer", "<cmd>WindowsMaximize<cr>" },
	},
	config = function()
		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false
		require("windows").setup({
			autowidth = {
				enable = false,
			},
			ignore = {
				buftype = { "quickfix" },
			},
			animation = {
				duration = 100,
				fps = 144,
				easing = "in_out_sine",
			},
		})
	end,
}
