local module = {}

---@return boolean,table
local function get_client_info()
	local ret = vim.system({ "wezterm", "cli", "list-clients", "--format", "json" }):wait()
	if ret.code ~= 0 then
		vim.notify("Failed to list wezterm info", vim.log.levels.WARN)
		return false, {}
	end
	return true, vim.json.decode(ret.stdout)
end

---@return boolean,table
local function get_list()
	local ret = vim.system({ "wezterm", "cli", "list", "--format", "json" }):wait()
	if ret.code ~= 0 then
		vim.notify("Failed to list wezterm info", vim.log.levels.WARN)
		return false, {}
	end
	local decoded = vim.json.decode(ret.stdout)
	return true, decoded
end

---@return integer | nil
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

	---@type table<string, table>
	local tab_id_to_info = tabs_in_focused_window
		:filter(function(entry)
			return entry.window_id == focused_window_id
		end)
		:fold({}, function(acc, entry)
			local tab_id = tostring(entry.tab_id)
			if acc[tab_id] then
				table.insert(acc[tab_id].panes, entry.pane_id)
			else
				acc[tab_id] = {
					title = entry.title,
					active = entry.pane_id == focused_pane_id,
					tab_id = tab_id,
					panes = { entry.pane_id },
				}
			end
			return acc
		end)

	local active_tab = vim.iter(tab_id_to_info)
		:map(function(_key, entry)
			return entry
		end)
		:find(function(entry)
			return entry.active == true
		end)

	if not active_tab then
		vim.notify("Failed to find active tab", vim.log.levels.WARN)
		return {}
	end

	if #active_tab.panes > 1 then
		return {}
	end

	local panes = vim.iter(tab_id_to_info)
		:map(function(_key, entry)
			return entry
		end)
		:totable()

	table.sort(panes, function(a, b)
		return a.tab_id < b.tab_id
	end)

	return panes
end

return module
