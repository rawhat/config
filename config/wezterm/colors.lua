local module = {}

local color_schemes = {
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
	["duskfox"] = {
		foreground = "#e0def4",
		background = "#232136",
		cursor_bg = "#e0def4",
		cursor_border = "#e0def4",
		cursor_fg = "#232136",
		selection_bg = "#433c59",
		selection_fg = "#e0def4",
		ansi = { "#393552", "#eb6f92", "#a3be8c", "#f6c177", "#569fba", "#c4a7e7", "#9ccfd8", "#e0def4" },
		brights = { "#47407d", "#f083a2", "#b1d196", "#f9cb8c", "#65b1cd", "#ccb1ed", "#a6dae3", "#e2e0f7" },
	},
	["nightfox"] = {
		-- oldest
		-- foreground = "#cdcecf",
		-- background = "#192330",
		-- cursor_bg = "#cdcecf",
		-- cursor_border = "#cdcecf",
		-- cursor_fg = "#192330",
		-- selection_bg = "#283648",
		-- selection_fg = "#cdcecf",
		-- ansi = { "#393b44", "#c94f6d", "#81b29a", "#dbc074", "#719cd6", "#9d79d6", "#63cdcf", "#dfdfe0" },
		-- brights = { "#7f8c98", "#d6616b", "#58cd8b", "#ffe37e", "#84cee4", "#b8a1e3", "#59f0ff", "#f2f2f2" },

		-- old
		-- foreground = "#cdcecf",
		-- background = "#192330",
		-- cursor_bg = "#cdcecf",
		-- cursor_border = "#cdcecf",
		-- cursor_fg = "#192330",
		-- selection_bg = "#283648",
		-- selection_fg = "#cdcecf",
		-- ansi = { "#393b44", "#c94f6d", "#81b29a", "#dbc074", "#719cd6", "#9d79d6", "#63cdcf", "#dfdfe0" },
		-- brights = { "#475072", "#d6616b", "#58cd8b", "#ffe37e", "#84cee4", "#b8a1e3", "#59f0ff", "#f2f2f2" },

		-- newest
		foreground = "#cdcecf",
		background = "#192330",
		cursor_bg = "#cdcecf",
		cursor_border = "#cdcecf",
		cursor_fg = "#192330",
		selection_bg = "#223249",
		selection_fg = "#cdcecf",
		ansi = { "#393b44", "#c94f6d", "#81b29a", "#dbc074", "#719cd6", "#9d79d6", "#63cdcf", "#dfdfe0" },
		brights = { "#575860", "#d16983", "#8ebaa4", "#e0c989", "#86abdc", "#baa1e2", "#7ad4d6", "#e4e4e5" },
	},
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
	kanagawa = {
		foreground = "#dcd7ba",
		background = "#1f1f28",

		cursor_bg = "#c8c093",
		cursor_fg = "#c8c093",
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#16161d",

		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
	},
	["catppuccin.mocha"] = {
		foreground = "#CDD6F4",
		background = "#1E1E2E",

		cursor_bg = "#F5E0DC",
		cursor_fg = "#1E1E2E",
		cursor_border = "#F5E0DC",

		selection_fg = "#1E1E2E",
		selection_bg = "#F5E0DC",

		-- scrollbar_thumb = "",
		-- split = "",

		-- black, red, green, yellow, blue, magenta, cyan, white
		ansi = { "#45475A", "#F38BA8", "#A6E3A1", "#F9E2AF", "#89B4FA", "#F5C2E7", "#94E2D5", "#BAC2DE" },
		brights = { "#45475A", "#F38BA8", "#A6E3A1", "#F9E2AF", "#89B4FA", "#F5C2E7", "#94E2D5", "#BAC2DE" },
	},
	["tundra"] = {
		foreground = "#D1D5DB",
		background = "#111827",

		cursor_fg = "#111827",
		cursor_bg = "#D1D5DB",
		cursor_border = "#111827",

		selection_fg = "#DDD6FE",
		selection_bg = "#374151",

		scrollbar_thumb = "#6B7280",
		split = "#6B7280",

		ansi = {
			"#6B7280",
			"#FCA5A5",
			"#B1E3AD",
			"#FBC19D",
			"#BAE6FD",
			"#957FB8",
			"#DDD6FE",
			"#A5F3FC",
		},
		brights = {
			"#6B7280",
			"#FCA5A5",
			"#B1E3AD",
			"#FBC19D",
			"#BAE6FD",
			"#938AA9",
			"#DDD6FE",
			"#A5F3FC",
		},
	},
	nordic = {
		cursor_bg = "#D8DEE9",
		cursor_fg = "#191c24",
		cursor_border = "#5E81AC",

		selection_fg = "#D8DEE9",
		selection_bg = "#60728A",

		background = "#191C24",
		foreground = "#D8DEE9",

		ansi = {
			"#191C24",
			"#BF616A",
			"#A3B38C",
			"#EBCB8B",
			"#81A1C1",
			"#B48EAD",
			"#8FBCBB",
			"#D8DEE9",
		},
		brights = {
			"#3B4252",
			"#D06F79",
			"#B1D196",
			"#F0D399",
			"#88C0D0",
			"#C895BF",
			"#93CCDC",
			"#E5E9F0",
		},
	},
}

module.color_scheme = "kanagawa (Gogh)"

function module.apply(config)
	config.color_schemes = color_schemes
	-- config.color_scheme = "ayu"
	-- config.color_scheme = "nightfox"
	-- config.color_scheme = "duskfox"
	-- config.color_scheme = "catppuccin"
	-- config.color_scheme = "kanagawa"
	-- config.color_scheme = "catppuccin.mocha"
	-- config.color_scheme = "tundra"
	-- config.color_scheme = "nordic"
	-- config.color_scheme = "Catppuccin Mocha"
	-- config.color_scheme = "Catppuccin Latte"
	-- config.color_scheme = "dayfox"
	config.color_scheme = module.color_scheme
	-- for kanagawa
	config.force_reverse_video_cursor = true
end

return module
