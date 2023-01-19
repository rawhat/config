require("lint").linters.coffeelint = {
	cmd = "coffeelint",
	append_fname = false,
	stdin = true,
	stream = "stdout",
	ignore_exitcode = true,
	env = nil,
	args = {
		"-s",
		"--reporter",
		"raw",
		"--color",
		"never",
	},
	parser = function(output, _)
		if vim.trim(output) == "" or output == nil then
			return {}
		end

		if not vim.startswith(output, "{") then
			vim.notify(output)
			return {}
		end

		local decoded = vim.json.decode(output)
		local diagnostics = {}
		local messages = decoded["stdin"]

		local severities = {
			error = vim.diagnostic.severity.ERROR,
			warning = vim.diagnostic.severity.WARN,
		}

		for _, msg in ipairs(messages or {}) do
			local split = vim.split(msg.message, ":")
			local col = tonumber(split[3])
			table.insert(diagnostics, {
				lnum = msg.lineNumber - 1,
				end_lnum = msg.lineNumber - 1,
				col = col,
				end_col = col + 1,
				message = msg.message,
				source = "coffeelint",
				severity = assert(severities[msg.level], "missing mapping for severity " .. msg.level),
			})
		end

		return diagnostics
	end,
}

require("lint").linters_by_ft = {
	coffee = { "coffeelint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
	pattern = { "*.coffee" },
	callback = function()
		require("lint").try_lint()
	end,
})
