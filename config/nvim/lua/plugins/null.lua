local null = require("null-ls")
local h = require("null-ls.helpers")
local b = null.builtins
local f = b.formatting
local d = b.diagnostics
local methods = require("null-ls.methods")

local gleam_format = h.make_builtin({
	method = { methods.internal.FORMATTING },
	filetypes = {
		"gleam",
	},
	generator_opts = {
		command = "gleam",
		args = h.range_formatting_args_factory({ "format", "--stdin" }),
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local fantomas_format = h.make_builtin({
	method = { methods.internal.FORMATTING },
	filetypes = {
		"fsharp",
	},
	generator_opts = {
		command = "dotnet",
		args = h.range_formatting_args_factory({ "fantomas", "--stdin", "--stdout" }),
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local sources = {
	-- formatters
	f.elm_format,
	f.gofmt,
	f.mix,
	f.prettier,
	f.rustfmt,
	f.stylua,
	f.yapf,
	fantomas_format,
	gleam_format,
	-- linters/checkers
	d.luacheck,
	-- d.pylint,
	-- i think this might just be super annoying
	-- d.write_good,
	d.codespell.with({ filetypes = { "markdown" } }),
}

null.setup({
	sources = sources,
})
