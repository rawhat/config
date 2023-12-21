local conform = require("conform")

local javascript_format = { { "prettify", "prettierd" } }

local util = require("conform.util")

conform.setup({
	formatters_by_ft = {
		bzl = { "buildifier" },
		java = { { "javafmt" } },
		javascript = javascript_format,
		javascriptreact = javascript_format,
		json = { "jq" },
		just = { "just" },
		lua = { "stylua" },
		python = { { "pyfmt", "black" } },
		typescript = javascript_format,
		typescriptreact = javascript_format,
		["_"] = { "trim_whitespace" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 5000,
	},
	formatters = {
		buildifier = {
			command = "buildifier",
			args = function(self, ctx)
				return { "-path=" .. ctx.filename }
			end,
			stdin = true,
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
		just = {
			command = "just",
			args = { "--fmt", "--unstable", "-f", "$FILENAME" },
			stdin = true,
		},
		prettify = {
			command = "bazel",
			args = { "run", "//tools/prettier", "--", "--stdin-filepath", "$FILENAME" },
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
