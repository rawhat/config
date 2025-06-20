return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context", opts = {} },
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"Rrethy/nvim-treesitter-endwise",
	},
	build = ":TSUpdate all",
	event = "BufEnter",
	keys = {
		{ "<leader>ts", desc = "TS Update", "<cmd>TSUpdate all<cr>" },
	},
	init = function()
		vim.treesitter.query.set(
			"gleam",
			"textobjects",
			[[
      ;extends
      (function
        (block
          .
          "{"
          .
          (_) @_start @_end
          (_)? @_end
          .
          "}"
          (#make-range! "function.inner" @_start @_end)) @function.outer)
      (anonymous_function
        (block
          .
          "{"
          .
          (_) @_start @_end
          (_)? @_end
          .
          "}"
          (#make-range! "function.inner" @_start @_end)) @function.outer)
        (_
          (block
            .
            "{"
            .
            (_) @_start @_end
            (_)? @_end
            .
            "}"
            (#make-range! "block.inner" @_start @_end)) @block.outer)
      ]]
		)

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
	end,
	opts = function()
		local treesitter = require("nvim-treesitter.configs")
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.gleam = {
			install_info = {
				url = "https://github.com/gleam-lang/tree-sitter-gleam",
				revision = "main",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "gleam",
		}

		return {
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
		}
	end,
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

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
