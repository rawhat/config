local null = require("null-ls")
local h = require("null-ls.helpers")
local b = null.builtins
local f = b.formatting
local d = b.diagnostics
local methods = require("null-ls.methods")

local function make_formatter(filetype, command, args)
	return h.make_builtin({
		method = methods.internal.FORMATTING,
		filetypes = { filetype },
		generator_opts = { command = command, args = args, to_stdin = true },
		factory = h.formatter_factory,
	})
end

local gleam_format = make_formatter("gleam", "gleam", { "format", "--stdin" })
local fantomas_format = make_formatter("fsharp", "dotnet", { "fantomas", "--stdin", "--stdout" })

local sources = {
	-- formatters
	f.elm_format,
	f.gofmt,
	f.mix,
	-- f.deno_fmt,
	-- `npm install -g @fsouza/prettierd`
	f.prettierd,
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
