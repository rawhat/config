local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local module = {}

local number_to_shift = {
	[1] = "!",
	[2] = "@",
	[3] = "#",
	[4] = "$",
	[5] = "%",
	[6] = "^",
	[7] = "&",
	[8] = "*",
}

local function move_pane_to_tab(window, pane_to_move, target_tab_index)
	local all_tabs = window:mux_window():tabs_with_info()
	wezterm.log_info(all_tabs)
	local target_tab
	for _, tab in pairs(all_tabs) do
		if target_tab_index - 1 == tab.index then
			target_tab = tab.tab
			break
		end
	end

	if not target_tab then
		wezterm.log_warn("Tab " .. target_tab_index .. " not found.")
		return
	end

	local target_pane
	for _, pane in pairs(target_tab:panes_with_info()) do
		if target_pane == nil or pane.index > target_pane.index then
			target_pane = pane
		end
	end

	if target_pane.pane:pane_id() == pane_to_move:pane_id() then
		wezterm.log_warn("Attempting to swap pane with itself...")
		return
	end

	local args = {
		"wezterm",
		"cli",
		"split-pane",
		"--right",
		"--percent",
		50,
		"--pane-id",
		target_pane.pane:pane_id(),
		"--move-pane-id",
		pane_to_move:pane_id(),
	}
	local success, stdout, stderr = wezterm.run_child_process(args)
	if not success then
		wezterm.log_error(stderr)
	end
end

function module.apply(config)
	config.disable_default_key_bindings = true

	config.key_tables = {
		vsplit = {
			{ key = "Enter", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		},
	}

	config.keys = {
		{
			key = "C",
			mods = "CTRL|SHIFT",
			action = wezterm.action.CopyTo("Clipboard"),
		},
		{
			key = "V",
			mods = "CTRL|SHIFT",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
		{
			key = "s",
			mods = "ALT",
			action = wezterm.action.Multiple({
				wezterm.action.EmitEvent("send-pane-to-new-window"),
				wezterm.action.EmitEvent("re-center-status"),
			}),
		},
		{
			key = "D",
			mods = "CTRL",
			action = wezterm.action.ShowDebugOverlay,
		},
		{
			key = "q",
			mods = "ALT",
			action = wezterm.action.Multiple({
				wezterm.action.CloseCurrentPane({ confirm = true }),
				wezterm.action.EmitEvent("re-center-status"),
			}),
		},
		{
			key = "x",
			mods = "ALT",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "n",
			mods = "ALT",
			action = wezterm.action.Multiple({
				wezterm.action.SpawnTab("CurrentPaneDomain"),
				wezterm.action.EmitEvent("re-center-status"),
			}),
		},
		{
			key = "w",
			mods = "ALT",
			action = wezterm.action.ShowTabNavigator,
		},
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "v",
			mods = "ALT",
			action = wezterm.action.ActivateKeyTable({ name = "vsplit", one_shot = true }),
		},
	}

	smart_splits.apply_to_config(config, {
		modifiers = {
			move = "ALT",
			resize = "CTRL|SHIFT",
		},
	})

	wezterm.on("send-pane-to-new-window", function(window, pane)
		local args = {
			"wezterm",
			"cli",
			"move-pane-to-new-tab",
			"--window-id",
			window:window_id(),
			"--pane-id",
			pane:pane_id(),
		}
		local success, stdout, stderr = wezterm.run_child_process(args)
		if not success then
			wezterm.log_error(stderr)
		end
	end)

	for i = 1, 8 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "ALT",
			action = wezterm.action.ActivateTab(i - 1),
		})
		table.insert(config.keys, {
			key = number_to_shift[i],
			mods = "ALT|SHIFT",
			action = wezterm.action.EmitEvent("send-pane-to-window-" .. tostring(i)),
		})
		wezterm.on("send-pane-to-window-" .. tostring(i), function(window, pane)
			move_pane_to_tab(window, pane, i)
		end)
	end
end

return module
