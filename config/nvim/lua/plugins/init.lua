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
		"JoosepAlviste/nvim-ts-context-commentstring",
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
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{
				"<leader>gk",
				"<cmd>GitLink current_branch<cr>",
				desc = "Get link to current line / range on current branch",
			},
			{
				"<leader>gt",
				"<cmd>GitLink default_branch<cr>",
				desc = "Get link to current line / range on default",
			},
			{
				"<leader>gp",
				"<cmd>GitLink rev=develop<cr>",
				desc = "Get link to current line / range on develop",
			},
		},
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
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
}
