local conform = require("conform")

local javascript_format = { { "prettify", "prettierd" } }

local util = require("conform.util")

local non_lsp_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"python",
	"java",
	"lua",
}

local function get_lsp_fallback(bufnr)
	local always = "always"
	for _, ft in pairs(non_lsp_filetypes) do
		if vim.bo[bufnr].filetype:match(ft) then
			always = true
			break
		end
	end
	return {
		lsp_fallback = always,
	}
end

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
		["*"] = { "trim_whitespace" },
	},
	format_on_save = function(bufnr)
		return {
			lsp_fallback = get_lsp_fallback(bufnr),
		}
	end,
	formatters = {
		buildifier = {
			command = "buildifier",
			args = function(ctx)
				return { "-path=" .. ctx.filename }
			end,
			stdin = true,
			cwd = util.root_file("WORKSPACE"),
			require_cwd = true,
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
