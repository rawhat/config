local null = require("null-ls")
local b = null.builtins
local f = b.formatting
local d = b.diagnostics

local sources = {
	-- formatters
	f.elm_format,
	f.eslint_d,
	f.gofmt,
	f.mix,
	f.prettier,
	f.rustfmt,
	f.stylua,
	f.ypf,

	-- linters/checkers
	d.eslint_d,
	d.luacheck,
	d.pylint,
	d.write_good,
}

null.config({
	sources = sources,
})

require("lspconfig")["null-ls"].setup({})
