return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			require("plenary.filetype").add_file("gleam")
		end,
	},
	{
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		opts = {},
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
			render = "wrapped-compact",
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
	{
		"ghostty",
		dir = "/Applications/Ghostty.app/Contents/Resources/vim/vimfiles/",
		lazy = false,
		cond = function()
			return vim.fn.executable("ghostty") == 1
		end,
	},
}
