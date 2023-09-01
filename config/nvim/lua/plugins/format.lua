local conform = require("conform")
local path = require("mason-core.path")
local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

local javascript_format = { "prettify", "prettierd" }

local jq = require("conform.formatters.jq")
jq.command = path.concat({ mason_data_path, "jq" })
local prettierd = require("conform.formatters.prettierd")
prettierd.command = path.concat({ mason_data_path, "prettierd" })

local util = require("conform.util")

conform.setup({
	formatters_by_ft = {
		bzl = { "buildifier" },
		java = { "javafmt" },
		javascript = javascript_format,
		javascriptreact = javascript_format,
		json = { "jq" },
		just = { "just" },
		lua = { "stylua" },
		python = { "pyfmt", "black" },
		typescript = javascript_format,
		typescriptreact = javascript_format,
	},
	format_on_save = {
		lsp_fallback = true,
	},
	formatters = {
		buildifier = {
			command = path.concat({ mason_data_path, "buildifier" }),
			args = { "-path=$FILENAME" },
		},
		javafmt = {
			command = "bazel",
			args = { "run", "//tools/java-format", "--", "--stdin" },
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
			args = { "run", "//tools/prettier", "--", "--stdin-filename", "$FILENAME" },
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
