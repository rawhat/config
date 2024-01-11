local M = {}

local has = function(version)
	return vim.fn.has(version) == 1
end

M.has = has

M.cwd = function()
	if has("nvim-0.10") then
		return vim.uv.cwd()
	else
		return vim.loop.cwd()
	end
end

M.gitiles = function()
	local notify = require("notify")
	local cwd = M.cwd()
	if cwd:find("^/home/alex/vistar/vistar") ~= nil then
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local file = vim.api.nvim_buf_get_name(0)
		local relative_path = string.gsub(file, M.cwd(), "")

		local gitiles_url = "https://gerrit.vistarmedia.com/plugins/gitiles/vistar/+/refs/heads/develop"

		local with_row = gitiles_url .. relative_path .. "#" .. row

		require("osc52").copy(with_row)
		notify("Gitiles URL copied to clipboard\n\n" .. with_row, "info")
	else
		notify("Can only be called from vistar root", "error")
	end
end

M.github = function()
	local notify = require("notify")
	local cwd = M.cwd()
	if cwd:find("^/home/alex/vistar/vistar") ~= nil then
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local file = vim.api.nvim_buf_get_name(0)
		local relative_path = string.gsub(file, M.cwd(), "")
		local github_url = "https://github.com/Vistar-Media/vistar/blob/develop"
		local with_row = github_url .. relative_path .. "#L" .. row

		require("osc52").copy(with_row)
		notify("Gitiles URL copied to clipboard\n\n" .. with_row, "info")
	else
		notify("Not implemented for anything other than the vistar repo")
	end
end

M.fs_stat = function(...)
	if has("nvim-0.10") then
		return vim.uv.fs_stat(...)
	else
		return vim.loop.fs_stat(...)
	end
end

M.get_lsp_clients = function(...)
	if has("nvim-0.10") then
		return vim.lsp.get_clients(...)
	else
		return vim.lsp.buf_get_clients(...)
	end
end

M.get_option_value = function(option, opts)
	local opts = opts or {}
	if has("nvim-0.10") then
		return vim.api.nvim_get_option_value(option, opts)
	elseif opts.buf ~= nil then
		return vim.api.nvim_buf_get_option(opts.buf, option)
	end
end

return M
