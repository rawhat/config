local wezterm = require('wezterm');

return {
    default_prog = {"S:\\Arch.exe"},

    font = wezterm.font("JetBrainsMono Nerd Font Mono"),

    scrollbar_thumb = "#222222",

    colors = {
        cursor_bg = "#c0caf5",
	cursor_fg = "#15161e",
	cursor_border = "#c0caf5",

        selection_bg = "#33467c",

        background = "#1a1b26",
        foreground = "#c0caf5",

        -- black, red, green, yellow, blue, magenta, cyan, white
        ansi = {"#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
        brights = {"#363b54", "#db4b4b", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"},
    },

    keys = {
       {
	        key = "1",
		mods="CTRL|SHIFT",
		action=wezterm.action{SpawnTab="CurrentPaneDomain"}
	},
	{
		key = "2",
		mods="CTRL|SHIFT",
		action=wezterm.action{
			SpawnCommandInNewTab={
				domain="CurrentPaneDomain",
				label="PowerShell",
				args={"C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe -WorkingDirectory ~"},
			}
		}
	},
    }
}
