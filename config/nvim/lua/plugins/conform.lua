return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		local util = require("conform.util")

		conform.setup({
			formatters_by_ft = {
				bzl = { "buildifier" },
				java = { { "javafmt" } },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "jq" },
				just = { "just" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				python = { { "pyfmt", "black" } },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				lsp_fallback = true,
			},
			notify_on_error = true,
			formatters = {
				javafmt = {
					command = "bazel",
					args = { "run", "//tools/java-format", "--", "--stdin", "--stdin-filepath", "$FILENAME" },
					stdin = true,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
				pyfmt = {
					command = "bazel",
					args = { "run", "//tools/pyfmt" },
					stdin = true,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
			},
		})
	end,
}
