return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			require("plenary.filetype").add_file("gleam")
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
	},
	{
		"nvimdev/hlsearch.nvim",
		event = "BufRead",
		opts = {},
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
	-- {
	-- 	"aileot/emission.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- },
	{
		"ghostty",
		dir = "/Applications/Ghostty.app/Contents/Resources/vim/vimfiles/",
		lazy = false,
		virtual = true,
		cond = function()
			return vim.fn.executable("ghostty") == 1
		end,
	},
}
