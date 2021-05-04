local wezterm = require('wezterm');
return {
    font = wezterm.font("JetBrainsMono Nerd Font"),

    enable_tab_bar = false,

    colors = {
        cursor_fg = "#c0caf5",
        selection_bg = "#33467c",

        background = "#1a1b26",
        foreground = "#c0caf5",

        -- black, red, green, yellow, blue, magenta, cyan, white
        ansi = {"#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
        brights = {"#363b54", "#db4b4b", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"},
    },
}
