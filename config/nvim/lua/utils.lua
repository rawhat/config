local M = {}

M.has = function(version)
	return vim.fn.has("nvim-" .. version) == 1
end

M.cwd = function()
	if M.has("0.10.0") then
		return vim.uv.cwd()
	else
		return vim.loop.cwd()
	end
end

M.github_url = function(remote)
	local result = vim.system({ "git", "remote", "get-url", (remote or "origin") }, { text = true }):wait()
	if result.code ~= 0 then
		return nil, nil
	end
	local remote_url = string.gsub(result.stdout, "\n", "")

	local repo = string.match(remote_url, "git@github.com:(.*).git")

	local head = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }):wait()
	local branch = string.gsub(head.stdout, "\n", "")
	local remote_exists = vim.system({ "git", "ls-remote", "--exit-code", "--heads", (remote or "origin"), branch })
		:wait()
	if remote_exists.code == 0 then
		return repo, branch
	end

	local develop = vim.system({ "git", "show-ref", "--quiet", "--branches", "develop" }):wait()
	if develop.code == 0 then
		return repo, "develop"
	else
		local main = vim.system({ "git", "show-ref", "--quiet", "--branches", "main" }):wait()
		if main.code == 0 then
			return repo, "main"
		end
	end

	return repo, "master"
end

M.github = function()
	local notify = require("notify")

	local url, branch = M.github_url()
	if not url then
		notify("Could not find GitHub URL")
		return
	end

	local cwd = M.cwd()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local file = vim.api.nvim_buf_get_name(0)
	local relative_path = string.gsub(file, cwd, "")
	local github_url = "https://github.com/" .. url .. "/blob/" .. branch
	local with_row = github_url .. relative_path .. "#L" .. row

	local ok, osc = pcall(require, "vim.ui.clipboard.osc52")
	if ok then
		osc.copy("+")({ with_row })
	else
		require("osc52").copy(with_row)
	end
	notify("GitHub URL copied to clipboard\n\n" .. with_row, "info")
end

M.fs_stat = function(...)
	if M.has("0.10.0") then
		return vim.uv.fs_stat(...)
	else
		return vim.loop.fs_stat(...)
	end
end

M.get_lsp_clients = function(...)
	if M.has("0.10.0") then
		return vim.lsp.get_clients(...)
	else
		return vim.lsp.buf_get_clients(...)
	end
end

M.get_option_value = function(option, opts)
	local opts = opts or {}
	if M.has("0.10.0") then
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
