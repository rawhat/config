return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		-- "nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		-- "Rrethy/nvim-treesitter-endwise",
	},
	branch = "main",
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

		local group = vim.api.nvim_create_augroup("treesitter", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = {
				"sh",
				"Dockerfile",
				"git",
				"lua",
				"gleam",
				"html",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"python",
				"go",
				"rust",
				"json",
			},
			callback = function()
				vim.treesitter.start()
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
	-- opts = function()
	--
	--    require("nvim-treesitter")
	--
	-- 	return {
	-- 		ensure_installed = {
	-- 			"bash",
	-- 			"dockerfile",
	-- 			"fish",
	-- 			"git_rebase",
	-- 			"gitcommit",
	-- 			"gleam",
	-- 			"html",
	-- 			"javascript",
	-- 			"json",
	-- 			"regex",
	-- 			"rust",
	-- 			"tsx",
	-- 			"typescript",
	-- 		},
	-- 		auto_install = true,
	-- 		highlight = {
	-- 			enable = true,
	-- 			additional_vim_regex_highlighting = false,
	-- 		},
	-- 		matchup = { enable = true },
	-- 		indent = {
	-- 			enable = true,
	-- 		},
	-- 		endwise = {
	-- 			enable = true,
	-- 		},
	-- 		textobjects = {
	-- 			select = {
	-- 				enable = true,
	-- 				lookahead = true,
	-- 				keymaps = {
	-- 					["af"] = "@function.outer",
	-- 					["if"] = "@function.inner",
	-- 					["ab"] = "@block.outer",
	-- 					["ib"] = "@block.inner",
	-- 				},
	-- 			},
	-- 		},
	-- 	}
	-- end,
	config = function()
		local parsers = require("nvim-treesitter.parsers")

		parsers.gleam = {
			install_info = {
				url = "https://github.com/gleam-lang/tree-sitter-gleam",
				ref = "HEAD",
			},
		}

		require("nvim-treesitter").install({
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
