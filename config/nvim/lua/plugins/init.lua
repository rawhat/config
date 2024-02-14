return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			require("plenary.filetype").add_file("gleam")
		end,
	},
	"romainl/vim-cool",
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					min_width = { 120 },
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			stages = "static",
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		opts = {
			autocmd = { enabled = true },
		},
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			-- colorcolumn = "81",
			disabled_filetypes = {
				"help",
				"lazy",
				"mason",
				"nvim-tree",
				"quickfix",
			},
		},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		opts = {},
	},
	{
		"gbprod/stay-in-place.nvim",
		opts = {},
	},
	{
		"tzachar/highlight-undo.nvim",
		opts = {},
	},
}
