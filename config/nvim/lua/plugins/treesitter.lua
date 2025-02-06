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
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.gleam = {
			install_info = {
				url = "/home/alex/repos/tree-sitter-gleam",
				files = { "src/parser.c", "src/scanner.c" },
			},
		}

		vim.treesitter.query.set(
			"gleam",
			"indent",
			[[
			 [
			   (anonymous_function)
			   (assert)
         (block)
			   (case)
			   (case_clause)
			   (constant)
			   (external_function)
			   (function)
			   (let)
			   (list)
			   (constant)
			   (function)
			   (type_definition)
			   (type_alias)
			   (todo)
			   (tuple)
			   (unqualified_imports)
			 ] @indent.begin

			 [
			   ")"
			   "]"
			   "}"
			 ] @indent.end @indent.branch

			 ; Gleam pipelines are not indented, but other binary expression chains are
			 ((binary_expression
			   operator: _ @_operator) @indent.begin
			   (#not-eq? @_operator "|>"))
			     ]]
		)

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
