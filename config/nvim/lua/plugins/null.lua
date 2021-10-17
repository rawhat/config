local null = require("null-ls")
local b = null.builtins
local f = b.formatting
local d = b.diagnostics

local sources = {
	-- formatters
	f.elm_format,
	f.gofmt,
	f.mix,
	f.prettier,
	f.rustfmt,
	f.stylua,
	f.ypf,
	-- linters/checkers
	d.luacheck,
	-- d.pylint,
	-- i think this might just be super annoying
	-- d.write_good,
	d.codespell.with({ filetypes = { "markdown" } }),
}

null.config({ sources = sources })

require("lspconfig")["null-ls"].setup({})
