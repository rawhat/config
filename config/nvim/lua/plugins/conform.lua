local js_formatters = {
	"prettierd",
	"prettier",
	lsp_format = "fallback",
	stop_after_first = true,
}

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
				ocaml = { "ocamlformat" },
				python = { "pyfmt", "ruff", stop_after_first = true },
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
					command = "./tools/java-format/node_modules/prettier/bin-prettier.js",
					args = { "--config", "config.json", "--parser", "java", "--plugin=prettier-plugin-java" },
					stdin = true,
					cwd = function()
						return "./tools/java-format"
					end,
					require_cwd = true,
				},
				pyfmt = {
					command = "yapf",
					args = function(self, ctx)
						local cwd = self.cwd(self, ctx)
						local yapf_style = require("utils").path_join(cwd, "tools", "pyfmt", ".style.yapf")
						return { "--quiet", "--style", yapf_style }
					end,
					range_args = function(self, ctx)
						local cwd = self.cwd(self, ctx)
						local yapf_style = require("utils").path_join(cwd, "tools", "pyfmt", ".style.yapf")
						return {
							"--quiet",
							"--style",
							yapf_style,
							"--lines",
							string.format("%d-%d", ctx.range.start[1], ctx.range["end"][1]),
						}
					end,
					cwd = util.root_file("WORKSPACE"),
					require_cwd = true,
				},
			},
		}
	end,
}
