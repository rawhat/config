local js_formatters = {
	"prettierd",
	"prettier",
	lsp_format = "fallback",
	stop_after_first = true,
}

return {
	"stevearc/conform.nvim",
	init = function()
		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
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
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
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
