local wezterm = require("wezterm")

-- local font = "JetBrains Mono"
-- local font = "Ligalex Mono"
-- local font = { family = "Hasklig", weight = "Medium" }
-- local font = "Hasklig"
-- local font = "Berkeley Mono Trial Regular"
-- local font = "Iosevka Plex"
local font = "Iosevka JetBrains Mono"
-- local font = { family = "Cascadia Code", weight = "DemiLight" }
-- local font = "Rec Mono Linear"

return {
	font = wezterm.font_with_fallback({ font, "nonicons", "Symbols Nerd Font Mono" }),
	font_size = 17.0,

	-- temporary
	front_end = "OpenGL",
	freetype_load_target = "Normal",
	freetype_load_flags = "NO_HINTING",

	window_padding = {
		top = 0,
		bottom = 0,
	},

	window_decorations = "RESIZE",

	enable_scroll_bar = false,
	scrollback_lines = 5000,
	enable_tab_bar = false,
	cursor_blink_rate = 0,

	-- (** light mode *)
	-- color_scheme = "dayfox",
	-- (** dark mode *)
	color_scheme = "Kanagawa (Gogh)",

	color_schemes = {
		["dayfox"] = {
			foreground = "#3d2b5a",
			background = "#f6f2ee",
			cursor_bg = "#3d2b5a",
			cursor_border = "#3d2b5a",
			cursor_fg = "#f6f2ee",
			compose_cursor = "#955f61",
			selection_bg = "#e7d2be",
			selection_fg = "#3d2b5a",
			scrollbar_thumb = "#824d5b",
			split = "#e4dcd4",
			visual_bell = "#3d2b5a",
			ansi = { "#352c24", "#a5222f", "#396847", "#ac5402", "#2848a9", "#6e33ce", "#287980", "#f2e9e1" },
			brights = { "#534c45", "#b3434e", "#577f63", "#b86e28", "#4863b6", "#8452d5", "#488d93", "#f4ece6" },

			tab_bar = {
				background = "#e4dcd4",
				inactive_tab_edge = "#e4dcd4",
				inactive_tab_edge_hover = "#dbd1dd",
			},
		},
	},
	keys = {
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
		{
			key = "R",
			mods = "CMD|SHIFT",
			action = wezterm.action.ReloadConfiguration,
		},
	},
}
