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

-- Thanks neo-tree!
local path_separator = "/"
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
if is_windows == true then
	path_separator = "\\"
end

---Split string into a table of strings using a separator.
---@param inputString string The string to split.
---@param sep string The separator to use.
---@return table table A table of strings.
local split = function(inputString, sep)
	local fields = {}

	local pattern = string.format("([^%s]+)", sep)
	local _ = string.gsub(inputString, pattern, function(c)
		fields[#fields + 1] = c
	end)

	return fields
end

---Joins arbitrary number of paths together.
---@param ... string The paths to join.
---@return string
M.path_join = function(...)
	local args = { ... }
	if #args == 0 then
		return ""
	end

	local all_parts = {}
	if type(args[1]) == "string" and args[1]:sub(1, 1) == path_separator then
		all_parts[1] = ""
	end

	for _, arg in ipairs(args) do
		if arg == "" and #all_parts == 0 and not is_windows then
			all_parts = { "" }
		else
			local arg_parts = split(arg, path_separator)
			vim.list_extend(all_parts, arg_parts)
		end
	end
	return table.concat(all_parts, path_separator)
end

return M
