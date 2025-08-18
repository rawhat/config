local js_formatters = { "prettierd", lsp_format = "fallback" }

return {
	"stevearc/conform.nvim",
	opts = function()
		local util = require("conform.util")

		return {
			formatters_by_ft = {
				bzl = { "buildifier" },
				java = { "javafmt", stop_after_first = true },
				javascript = js_formatters,
				javascriptreact = js_formatters,
				json = { "jq" },
				just = { "just" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				python = { "pyfmt", "black", stop_after_first = true },
				proto = { "trim_whitespace" },
				sql = { "sleek" },
				typescript = js_formatters,
				typescriptreact = js_formatters,
				["_"] = { "trim_whitespace", lsp_format = "prefer" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 500,
			},
			log_level = vim.log.levels.TRACE,
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
		}
	end,
}
