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
		local present, treesitter = pcall(require, "nvim-treesitter.configs")

		if not present then
			error("Couldn't load treesitter")
			return
		end

		local utils = require("utils")

		treesitter.setup({
			ensure_installed = "all",
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
				disable = function(_, buf)
					local max_filesize = 1024 * 1024 -- 1mb
					local ok, stats = pcall(utils.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			matchup = { enable = true },
			autopairs = { enable = true },
			autotag = {
				enable = true,
				enable_close_on_slash = false,
			},
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
	end,
}
