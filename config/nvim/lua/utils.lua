local M = {}

local has = function(version)
	return vim.fn.has("nvim-" .. version) == 1
end

M.has = has

M.cwd = function()
	if has("0.10") then
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
	if cwd:find("^/home/alex/vistar/vistar") ~= nil or cwd:find("^/Users/amanning/vistar/vistar") then
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local file = vim.api.nvim_buf_get_name(0)
		local relative_path = string.gsub(file, M.cwd(), "")
		local github_url = "https://github.com/Vistar-Media/vistar/blob/develop"
		local with_row = github_url .. relative_path .. "#L" .. row

		local ok, osc = pcall(require, "vim.ui.clipboard.osc52")
		if ok then
			osc.copy("+")({ with_row })
		else
			require("osc52").copy(with_row)
		end
		notify("Gitiles URL copied to clipboard\n\n" .. with_row, "info")
	else
		notify("Not implemented for anything other than the vistar repo")
	end
end

M.fs_stat = function(...)
	if has("0.10") then
		return vim.uv.fs_stat(...)
	else
		return vim.loop.fs_stat(...)
	end
end

M.get_lsp_clients = function(...)
	if has("0.10") then
		return vim.lsp.get_clients(...)
	else
		return vim.lsp.buf_get_clients(...)
	end
end

M.get_option_value = function(option, opts)
	local opts = opts or {}
	if has("0.10") then
		return vim.api.nvim_get_option_value(option, opts)
	elseif opts.buf ~= nil then
		return vim.api.nvim_buf_get_option(opts.buf, option)
	end
end

M.swap_windows = function()
	local win_to_swap = require("window-picker").pick_window()
	if win_to_swap == nil or win_to_swap == 0 then
		return
	end
	local current_buf = vim.api.nvim_win_get_buf(0)
	local buf_to_swap = vim.api.nvim_win_get_buf(win_to_swap)
	vim.api.nvim_win_set_buf(0, buf_to_swap)
	vim.api.nvim_win_set_buf(win_to_swap, current_buf)
	vim.api.nvim_set_current_win(win_to_swap)
end

M.shuffle = function(t)
	local tbl = {}
	for i = 1, #t do
		tbl[i] = t[i]
	end
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

return M
