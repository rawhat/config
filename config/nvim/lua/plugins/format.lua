local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

local path = require("mason-core.path")
local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

local is_windows = vim.uv.os_uname().version:match("Windows")
local path_separator = is_windows and "\\" or "/"

local path_join = function(...)
	return table.concat(vim.tbl_flatten({ ... }), path_separator):gsub(path_separator .. "+", path_separator)
end

local path_exists = function(filename)
	local stat = vim.uv.fs_stat(filename)
	return stat ~= nil
end

local root_has_file = function(...)
	-- TODO:  is this good enough?
	local root = vim.uv.cwd()
	local patterns = vim.tbl_flatten({ ... })
	for _, name in ipairs(patterns) do
		if path_exists(path_join(root, name)) then
			return true
		end
	end
	return false
end

local pyfmt = formatters.shell({ cmd = { "bazel", "run", "//tools/pyfmt" } })

local javafmt = formatters.shell({ cmd = { "bazel", "run", "//tools/java-format", "--", "--stdin" } })

local buildifier = formatters.shell({ cmd = { path.concat({ mason_data_path, "buildifier" }), "-path=%" } })

local prettify = formatters.shell({ cmd = { "bazel", "run", "//tools/prettier", "--", "--stdin-filepath", "%" } })

local prettierd = formatters.shell({ cmd = { path.concat({ mason_data_path, "prettierd" }), "%" } })

local javascript_format = function()
	if root_has_file({ "WORKSPACE" }) then
		return prettify
	else
		return prettierd
	end
end

local java_format = function()
	if root_has_file({ "WORKSPACE" }) then
		return javafmt
	else
		return formatters.lsp
	end
end

local formatters_by_ft = {
	bzl = buildifier,
	c = formatters.lsp,
	clojure = formatters.lsp,
	cpp = formatters.lsp,
	crystal = formatters.lsp,
	eex = formatters.lsp,
	elixir = formatters.lsp,
	erlang = formatters.lsp,
	fsharp = formatters.lsp,
	gleam = formatters.lsp,
	go = formatters.lsp,
	heex = formatters.lsp,
	html = formatters.lsp,
	java = java_format,
	javascript = javascript_format,
	javascriptreact = javascript_format,
	json = formatters.shell({ cmd = { path.concat({ mason_data_path, "jq" }) } }),
	jsonnet = formatters.lsp,
	just = formatters.shell({ cmd = { "just", "--fmt", "--unstable", "-f", "%" } }),
	leex = formatters.lsp,
	lua = formatters.stylua,
	ocaml = formatters.lsp,
	python = function()
		if root_has_file({ "WORKSPACE" }) then
			return pyfmt
		else
			return formatters.black
		end
	end,
	ruby = formatters.lsp,
	sql = formatters.lsp,
	toml = formatters.lsp,
	typescript = javascript_format,
	typescriptreact = javascript_format,
	zig = formatters.lsp,
}

format_on_save.setup({
	exclude_path_patterns = {
		"/node_modules/",
		".local/share/nvim/lazy",
		"/bazel-*/",
	},
	stderr_loglevel = vim.log.levels.OFF,
	formatter_by_ft = formatters_by_ft,
})
