local wezterm = require("wezterm")

local module = {}

function module.apply(config)
	config.disable_default_key_bindings = true

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

	config.key_tables = {
		vsplit = {
			{ key = "Enter", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		},
	}

	config.keys = {
		{
			key = "s",
			mods = "ALT",
			action = wezterm.action.EmitEvent("send-pane-to-new-window"),
		},
		{
			key = "L",
			mods = "CTRL",
			action = wezterm.action.ShowDebugOverlay,
		},
		{
			key = "q",
			mods = "ALT",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "x",
			mods = "ALT",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "n",
			mods = "ALT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
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
		{
			key = "h",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "ALT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
	}

	for i = 1, 8 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "ALT",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

return module
