local wezterm = require("wezterm")

local font = "JetBrainsMono NF"
-- local font = "CaskaydiaCove NF"
-- local font = "FiraCode NF"
-- local font = "Hasklug NF"
-- local font = "Iosevka"
-- local font = "VictorMono Nerd Font"
return {
	default_prog = { "S:\\Arch.exe" },

	font = wezterm.font(font),
	font_size = 13.0,

	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font(font, {
				weight = "Bold",
			}),
		},
		{
			italic = true,
			font = wezterm.font(font, {
				italic = true,
				weight = "Regular",
			}),
		},
	},

	enable_scroll_bar = true,
	scrollback_lines = 5000,

	-- color_scheme = "ayu",
	color_scheme = "nightfox",

	color_schemes = {
		["tokyonight"] = {
			cursor_bg = "#c0caf5",
			cursor_fg = "#15161e",
			cursor_border = "#c0caf5",

			selection_bg = "#33467c",

			-- background = "#1a1b26",
			background = "#ffffff",
			foreground = "#c0caf5",

			-- black, red, green, yellow, blue, magenta, cyan, white
			ansi = { "#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
			brights = { "#363b54", "#db4b4b", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
		},
		["nightfox"] = {
			foreground = "#cdcecf",
			background = "#192330",
			cursor_bg = "#cdcecf",
			cursor_border = "#cdcecf",
			cursor_fg = "#192330",
			selection_bg = "#283648",
			selection_fg = "#cdcecf",
			ansi = { "#393b44", "#c94f6d", "#81b29a", "#dbc074", "#719cd6", "#9d79d6", "#63cdcf", "#dfdfe0" },
			brights = { "#7f8c98", "#d6616b", "#58cd8b", "#ffe37e", "#84cee4", "#b8a1e3", "#59f0ff", "#f2f2f2" },
		},
		["nightfly"] = {
			cursor_bg = "#9ca1aa",
			cursor_fg = "#080808",
			cursor_border = "#9ca1aa",

			selection_bg = "#b2ceee",

			background = "#011627",
			foreground = "#acb4c2",

			-- black, red, green, yellow, blue, magenta, cyan, white
			ansi = { "#1d3b53", "#fc514e", "#a1cd5e", "#e3d18a", "#82aaff", "#c792ea", "#7fdbca", "#a1aab8" },
			brights = { "#7c8f8f", "#ff5874", "#21c7a8", "#ecc48d", "#82aaff", "#ae81ff", "#7fdbca", "#d6deeb" },
		},
	},

	keys = {
		{
			key = "h",
			mods = "ALT",
			action = wezterm.action({
				ActivateTabRelative = -1,
			}),
		},
		{
			key = "l",
			mods = "ALT",
			action = wezterm.action({
				ActivateTabRelative = 1,
			}),
		},
		{
			key = "1",
			mods = "CTRL|SHIFT",
			action = wezterm.action({
				SpawnTab = "CurrentPaneDomain",
			}),
		},
		{
			key = "2",
			mods = "CTRL|SHIFT",
			action = wezterm.action({
				SpawnCommandInNewTab = {
					label = "PowerShell",
					args = { "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe -NoExit -WorkingDirectory ~" },
					-- args = {"C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe -Command {$Env}"} -- -NoExit -Command \"& 'C:\\Users\\Alex\\.cargo\\bin\\starship.exe' init powershell --print-full-init | Out-String\""}
					-- args = {"C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe -NoProfile -NoExit -Command \"Invoke-Expression (& 'C:\\Users\\Alex\\.cargo\\bin\\starship.exe' init powershell --print-full-init | Out-String)\""}
					-- args = {"pwsh.exe"}
				},
			}),
		},
		{
			key = "F11",
			action = "ToggleFullScreen",
		},
	},
}
