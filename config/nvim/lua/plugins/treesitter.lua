local function sto(selector, query_group)
	return function()
		require("nvim-treesitter-textobjects.select").select_textobject(selector, query_group)
	end
end

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context", opts = {} },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			keys = {
				{ "af", sto("@function.outer"), mode = { "x", "o" }, desc = "Function outer" },
				{ "if", sto("@function.inner"), mode = { "x", "o" }, desc = "Function inner" },
				{ "ab", sto("@block.outer"), mode = { "x", "o" }, desc = "Body outer" },
				{ "ib", sto("@block.inner"), mode = { "x", "o" }, desc = "Body inner" },
			},
		},
		"windwp/nvim-ts-autotag",
		"RRethy/nvim-treesitter-endwise",
	},
	branch = "main",
	build = ":TSUpdate all",
	lazy = false,
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
         (arguments)
         (assert)
         (block)
			   (case)
			   (case_clause)
			   (constant)
         (data_constructor)
         (data_constructor_argument)
         (data_constructor_arguments)
			   (external_function)
			   (function)
			   (let)
			   (list)
			   (todo)
			   (tuple)
			   (type_alias)
			   (type_definition)
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
		-- vim.treesitter.query.set(
		-- 	"gleam",
		-- 	"highlights",
		-- 	[[;extends
		--       ; Inject markdown into documentation comments
		--       ((doc_comment_content) @injection.content
		--        (#set! injection.language "markdown")
		--        (#set! injection.combined))
		--     ]]
		-- )
	end,
	config = function(plug)
		vim.opt.rtp:prepend(plug.dir)

		require("nvim-treesitter").install({
			"bash",
			"caddy",
			"css",
			"csv",
			"dockerfile",
			"ecma",
			"elixir",
			"erlang",
			"fish",
			"git_config",
			"git_rebase",
			"gitcommit",
			"gitignore",
			"gleam",
			"go",
			"go_mod",
			"heex",
			"html",
			"html_tags",
			"ini",
			"javascript",
			"java",
			"json",
			"jsonnet",
			"jsx",
			"lua",
			"markdown",
			"proto",
			"python",
			"regex",
			"rust",
			"scala",
			"scss",
			"sh",
			"sql",
			"starlark",
			"toml",
			"tsx",
			"typescript",
			"yaml",
		})

		local indent_cache = {}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(ev)
				local ft = ev.match
				local lang = vim.treesitter.language.get_lang(ft)
				if lang and vim.treesitter.language.add(lang) then
					if not vim.tbl_contains(indent_cache, lang) then
						local has_indents = vim.treesitter.query.get(lang, "indents") and true
						indent_cache[lang] = has_indents
					end
					local should_indent = indent_cache[lang]
					if should_indent then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.treesitter.start(ev.buf, lang)
				end
			end,
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
