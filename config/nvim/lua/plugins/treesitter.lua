return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"Rrethy/nvim-treesitter-endwise",
	},
	build = ":TSUpdate all",
	event = "BufEnter",
	keys = {
		{ "<leader>ts", desc = "TS Update", "<cmd>TSUpdate all<cr>" },
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = {
				"bash",
				"dockerfile",
				"fish",
				"git_rebase",
				"gitcommit",
				"gleam",
				"html",
				"javascript",
				"json",
				"regex",
				"rust",
				"tsx",
				"typescript",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			matchup = { enable = true },
			indent = {
				enable = true,
			},
			endwise = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
					},
				},
			},
		})

		require("nvim-ts-autotag").setup({
			enable = true,
			enable_close_on_slash = false,
		})

		require("treesitter-context").setup({
			multiline_threshold = 6,
			max_lines = 6,
		})
	end,
}
