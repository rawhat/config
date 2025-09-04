local module = {}

local function get_client_info()
	local ret = vim.system({ "wezterm", "cli", "list-clients", "--format", "json" }):wait()
	if ret.code ~= 0 then
		vim.notify("Failed to list wezterm info", vim.log.levels.WARN)
		return false, {}
	end
	return true, vim.json.decode(ret.stdout)
end

local function get_list()
	local ret = vim.system({ "wezterm", "cli", "list", "--format", "json" }):wait()
	if ret.code ~= 0 then
		vim.notify("Failed to list wezterm info", vim.log.levels.WARN)
		return false, {}
	end
	local decoded = vim.json.decode(ret.stdout)
	return true, decoded
end

local function get_focused_pane()
	local ok, info = get_client_info()
	if not ok then
		return nil
	else
		return info[1].focused_pane_id
	end
end

function module.get_tabs()
	local ok, list = get_list()
	if not ok or #list == 1 then
		return {}
	end
	local focused_pane_id = get_focused_pane()
	local focused_window_id = vim.iter(list):find(function(entry)
		return entry.pane_id == focused_pane_id
	end).window_id
	local tabs_in_focused_window = vim.iter(list):filter(function(entry)
		return entry.window_id == focused_window_id
	end)

	local tab_id_to_info = tabs_in_focused_window
		:filter(function(entry)
			return entry.window_id == focused_window_id
		end)
		:fold({}, function(acc, entry)
			if acc[entry.tab_id] then
				table.insert(acc[entry.tab_id].panes, entry.pane_id)
			else
				acc[entry.tab_id] = {
					title = entry.title,
					active = entry.pane_id == focused_pane_id,
					tab_id = entry.tab_id,
					panes = { entry.pane_id },
				}
			end
			return acc
		end)

	local values = vim.iter(tab_id_to_info)
		:map(function(key, entry)
			if type(key) == "number" then
				return entry
			else
				return key
			end
		end)
		:totable()

	local more_than_nvim_in_tab = vim.iter(values):find(function(entry)
		return #entry.panes > 1
	end)

	if more_than_nvim_in_tab then
		return {}
	end

	table.sort(values, function(a, b)
		return a.tab_id < b.tab_id
	end)

	return values
end

return module
