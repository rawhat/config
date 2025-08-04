local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

local is_macos = wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin"
local wezterm_binary = "wezterm"
if is_macos then
	wezterm_binary = "/opt/homebrew/bin/wezterm"
end

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
		wezterm_binary,
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

local key_to_direction = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

function bind_nvim_keys(key, mods, action)
	return function(window, pane)
		local is_nvim = pane:get_foreground_process_name():match(".*/([^/]+)$") == "nvim"
		if not is_nvim then
			if action ~= "resize" then
				window:perform_action({ ActivatePaneDirection = key_to_direction[key] }, pane)
			else
				window:perform_action({ AdjustPaneSize = { key_to_direction[key], 3 } }, pane)
			end
		else
			if action ~= "resize" then
				window:perform_action({ SendKey = { key = key, mods = mods } }, pane)
			else
				window:perform_action({ SendKey = { key = key, mods = "CTRL|ALT" } }, pane)
			end
		end
	end
end

function module.apply(config)
	config.disable_default_key_bindings = true

	config.key_tables = {
		vsplit = {
			{ key = "Enter", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		},
	}

	local leader_mod = "ALT"
	if is_macos then
		leader_mod = "SUPER"
	end

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
			mods = leader_mod,
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
			mods = leader_mod,
			action = wezterm.action.Multiple({
				wezterm.action.CloseCurrentPane({ confirm = true }),
				wezterm.action.EmitEvent("re-center-status"),
			}),
		},
		{
			key = "x",
			mods = leader_mod,
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "n",
			mods = leader_mod,
			action = wezterm.action.Multiple({
				wezterm.action.SpawnTab("CurrentPaneDomain"),
				wezterm.action.EmitEvent("re-center-status"),
			}),
		},
		{
			key = "w",
			mods = leader_mod,
			action = wezterm.action.ShowTabNavigator,
		},
		{
			key = "Enter",
			mods = leader_mod,
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "v",
			mods = leader_mod,
			action = wezterm.action.ActivateKeyTable({ name = "vsplit", one_shot = true }),
		},
		{
			key = "L",
			mods = leader_mod .. "|SHIFT",
			action = wezterm.action.RotatePanes("Clockwise"),
		},
		{
			key = "H",
			mods = leader_mod .. "|SHIFT",
			action = wezterm.action.RotatePanes("CounterClockwise"),
		},
		{
			key = "=",
			mods = leader_mod,
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "-",
			mods = leader_mod,
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "0",
			mods = leader_mod,
			action = wezterm.action.ResetFontSize,
		},
		{
			key = "m",
			mods = leader_mod,
			action = wezterm.action.ShowLauncher,
		},
		{
			key = "h",
			mods = leader_mod,
			action = wezterm.action_callback(bind_nvim_keys("h", "ALT")),
		},
		{
			key = "j",
			mods = leader_mod,
			action = wezterm.action_callback(bind_nvim_keys("j", "ALT")),
		},
		{
			key = "k",
			mods = leader_mod,
			action = wezterm.action_callback(bind_nvim_keys("k", "ALT")),
		},
		{
			key = "l",
			mods = leader_mod,
			action = wezterm.action_callback(bind_nvim_keys("l", "ALT")),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(bind_nvim_keys("h", "CTRL|SHIFT", "resize")),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(bind_nvim_keys("j", "CTRL|SHIFT", "resize")),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(bind_nvim_keys("k", "CTRL|SHIFT", "resize")),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(bind_nvim_keys("l", "CTRL|SHIFT", "resize")),
		},
	}

	wezterm.on("send-pane-to-new-window", function(window, pane)
		local args = {
			wezterm_binary,
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
			mods = leader_mod,
			action = wezterm.action.ActivateTab(i - 1),
		})
		table.insert(config.keys, {
			key = number_to_shift[i],
			mods = leader_mod .. "|SHIFT",
			action = wezterm.action.EmitEvent("send-pane-to-window-" .. tostring(i)),
		})
		wezterm.on("send-pane-to-window-" .. tostring(i), function(window, pane)
			move_pane_to_tab(window, pane, i)
		end)
	end
end

return module
