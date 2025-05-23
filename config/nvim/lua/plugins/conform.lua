return {
	"stevearc/conform.nvim",
	opts = function()
		local util = require("conform.util")

		return {
			formatters_by_ft = {
				bzl = { "my_buildifier" },
				gleam = { lsp_format = "fallback" },
				java = { "javafmt", stop_after_first = true },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "jq" },
				just = { "just" },
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
				python = { "pyfmt", "black", stop_after_first = true },
				rust = { lsp_format = "fallback" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			log_level = vim.log.levels.TRACE,
			notify_on_error = true,
			formatters = {
				my_buildifier = {
					command = "buildifier",
					args = { "$FILENAME" },
					stdin = false,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
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
