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

linters.buildifier = {
	cmd = path.concat({ mason_data_path, "buildifier" }),
	stdin = true,
	args = {
		"-mode=check",
		"-lint=warn",
		"-format=json",
		function()
			return "-path=" .. vim.fn.expand("%:.")
		end,
	},
	parser = function(output, bufnr)
		local filename = vim.api.nvim_buf_get_name(bufnr)
		filename = vim.fn.fnamemodify(filename, ":.")
		local warnings = {}
		local errors = {}
		local encoded = vim.json.decode(output)
		for _, entry in pairs(encoded.files or {}) do
			if entry.filename == filename then
				warnings = entry.warnings or {}
				errors = errors.errors or {}
			end
		end
		local diagnostics = {}
		for _, warning in pairs(warnings) do
			table.insert(diagnostics, {
				bufnr = bufnr,
				lnum = warning.start.line - 1,
				end_lnum = warning["end"].line - 1,
				col = warning.start.column,
				end_col = warning["end"].column,
				severity = vim.diagnostic.severity.WARNING,
				message = warning.message,
				source = "buildifier",
				code = warning.category,
			})
		end
		for _, error in pairs(errors) do
			table.insert(diagnostics, {
				bufnr = bufnr,
				lnum = error.start.line - 1,
				end_lnum = error["end"].line - 1,
				col = error.start.column,
				end_col = error["end"].column,
				severity = vim.diagnostic.severity.ERROR,
				message = error.message,
				source = "buildifier",
				code = error.category,
			})
		end

		return diagnostics
	end,
}

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
