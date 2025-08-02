local module = {}

function module.get_client_info()
	local ret = vim.system({ "wezterm", "cli", "list-clients", "--format", "json" }):wait()
	if ret.code ~= 0 then
		vim.notify("Failed to list wezterm info", vim.log.levels.WARN)
		return false, {}
	end
	return true, vim.json.decode(ret.stdout)
end

function module.get_list()
	local ret = vim.system({ "wezterm", "cli", "list", "--format", "json" }):wait()
	if ret.code ~= 0 then
		vim.notify("Failed to list wezterm info", vim.log.levels.WARN)
		return false, {}
	end
	local decoded = vim.json.decode(ret.stdout)
	return true, decoded
end

function module.get_focused_pane()
	local ok, info = module.get_client_info()
	if not ok then
		return nil
	else
		return info[1].focused_pane_id
	end
end

function module.get_tabs()
	local ok, list = module.get_list()
	if not ok then
		return {}
	end
	local focused_pane = module.get_focused_pane()

	local tab_id_to_title = {}
	for _, entry in pairs(list) do
		if tab_id_to_title[entry.tab_id] == nil then
			tab_id_to_title[entry.tab_id] = {
				title = entry.title,
				active = entry.pane_id == focused_pane,
				tab_id = entry.tab_id,
			}
		end
	end

	local values = vim.iter(tab_id_to_title):totable()
	table.sort(values, function(a, b)
		return a.tab_id < b.tab_id
	end)

	return values
end

return module
