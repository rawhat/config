local wezterm = require("wezterm")

local module = {}

function module.apply(config)
	config.keys = {
		-- {
		-- 	key = "h",
		-- 	mods = "ALT",
		-- 	action = wezterm.action({
		-- 		ActivateTabRelative = -1,
		-- 	}),
		-- },
		-- {
		-- 	key = "l",
		-- 	mods = "ALT",
		-- 	action = wezterm.action({
		-- 		ActivateTabRelative = 1,
		-- 	}),
		-- },
		{
			key = "1",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "2",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SpawnCommandInNewTab({
				label = "PowerShell",
				args = { "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe -NoExit -WorkingDirectory ~" },
			}),
		},
		{
			key = "h",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "j",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "k",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "l",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- {
		-- 	key = "4",
		-- 	mods = "CTRL|SHIFT",
		-- 	action = wezterm.action({

		-- 	}),
		-- },
		{
			key = "F11",
			action = "ToggleFullScreen",
		},
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "1",
			mods = "ALT|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "2",
			mods = "ALT|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "3",
			mods = "ALT|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	}
end

return module
