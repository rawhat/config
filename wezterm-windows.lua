local wezterm = require('wezterm');

return {
    default_prog = {"S:\\Arch.exe"},

    -- font = wezterm.font("FiraCode Nerd Font"),
    -- font = wezterm.font("Liga Iosevka Term"),
    font = wezterm.font("JetBrainsMono Nerd Font Mono"),
    -- font = wezterm.font("Cascadia Code PL"),
    -- font = wezterm.font("VictorMono Nerd Font"),
    font_size = 13.0,

    enable_scroll_bar = true,
    scrollback_lines = 5000,

    -- Tokyo Night
    colors = {
        cursor_bg = "#c0caf5",
        cursor_fg = "#15161e",
        cursor_border = "#c0caf5",

        selection_bg = "#33467c",

        background = "#1a1b26",
        foreground = "#c0caf5",

        -- black, red, green, yellow, blue, magenta, cyan, white
        ansi = {"#15161e", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
        brights = {"#363b54", "#db4b4b", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"}
    },

    -- Nightfly
    --[[
    colors = {
        cursor_bg = "#9ca1aa",
        cursor_fg = "#080808",
        cursor_border = "#9ca1aa",

        selection_bg = "#b2ceee",

        background = "#011627",
        foreground = "#acb4c2",

        -- black, red, green, yellow, blue, magenta, cyan, white
        ansi = {'#1d3b53', '#fc514e', '#a1cd5e', '#e3d18a', '#82aaff', '#c792ea', '#7fdbca', '#a1aab8'},
        brights = {'#7c8f8f', '#ff5874', '#21c7a8', '#ecc48d', '#82aaff', '#ae81ff', '#7fdbca', '#d6deeb'}
    },
    --]]

    keys = {{
        key = "h",
        mods = "ALT",
        action = wezterm.action {
            ActivateTabRelative = -1
        }
    }, {
        key = "l",
        mods = "ALT",
        action = wezterm.action {
            ActivateTabRelative = 1
        }
    }, {
        key = "1",
        mods = "CTRL|SHIFT",
        action = wezterm.action {
            SpawnTab = "CurrentPaneDomain"
        }
    }, {
        key = "2",
        mods = "CTRL|SHIFT",
        action = wezterm.action {
            SpawnCommandInNewTab = {
                domain = "CurrentPaneDomain",
                label = "PowerShell",
                args = {"C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe -WorkingDirectory ~"}
            }
        }
    }}
}
