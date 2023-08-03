local path = require("mason-core.path")
local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

local linters = require("lint").linters

linters.coffeelint = {
	cmd = "coffeelint",
	stdin = true,
	args = { "-s", "--reporter", "raw", "--nocolor", "--quiet" },
	ignore_exitcode = true,
	parser = function(output, bufnr)
		local decoded = vim.json.decode(output)

		local matcher = "%[stdin%]:(%d+):(%d+):[%s*]error: (.-)\n.*"
		local groups = { "lnum", "col", "message" }

		local diagnostics = {}

		for _, entry in pairs(decoded.stdin) do
			local matches = { entry.message:match(matcher) }
			local captures = {}
			for i, match in ipairs(matches) do
				captures[groups[i]] = match
			end

			table.insert(diagnostics, {
				bufnr = bufnr,
				lnum = tonumber(captures.lnum) - 1,
				col = tonumber(captures.col) - 1,
				message = captures.message,
				severity = vim.diagnostic.severity.ERROR,
				source = "coffeelint",
			})
		end

		return diagnostics
	end,
}

linters.buildifier.command = path.concat({ mason_data_path, "buildifier" })
linters.eslint_d.command = path.concat({ mason_data_path, "eslint_d" })
linters.ruff.command = path.concat({ mason_data_path, "ruff" })

local elixir_linters = { "credo" }
local javascript_linters = { "eslint_d" }

require("lint").linters_by_ft = {
	bzl = { "buildifier" },
	coffee = { "coffeelint" },
	elixir = elixir_linters,
	leex = elixir_linters,
	heex = elixir_linters,
	eex = elixir_linters,
	javascript = javascript_linters,
	javascriptreact = javascript_linters,
	typescript = javascript_linters,
	typescriptreact = javascript_linters,
	python = { "ruff" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
