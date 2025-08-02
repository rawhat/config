local wezterm = require("wezterm")
local font = require("fonts")
local colors = require("colors")

local module = {}

local function apply_tab_bar(config)
	local scheme = wezterm.color.get_builtin_schemes()[colors.color_scheme]
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = false
	config.window_frame = {
		font = wezterm.font({ family = font.current_font, weight = "Bold" }),
	}
	config.colors = {
		tab_bar = {
			background = scheme.background,
		},
	}
	wezterm.on("format-tab-title", function(tab, tabs, panes, configuration, hover, max_width)
		local background = scheme.background
		local foreground = scheme.foreground
		return {
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
			{ Background = { Color = foreground } },
			{ Foreground = { Color = background } },
			{ Text = tab.active_pane.title .. " " },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
			{ Background = { Color = foreground } },
			{ Foreground = { Color = background } },
		}
	end)
	-- config.tab_bar_style = {
	-- 	active_tab_left = wezterm.format({
	-- 		{ Background = { Color = scheme.background } },
	-- 		{ Foreground = { Color = scheme.foreground } },
	-- 		{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
	-- 	}),
	-- 	active_tab_right = wezterm.format({
	-- 		{ Background = { Color = scheme.background } },
	-- 		{ Foreground = { Color = scheme.foreground } },
	-- 		{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
	-- 	}),
	-- 	inactive_tab_left = wezterm.format({
	-- 		{ Background = { Color = scheme.background } },
	-- 		{ Foreground = { Color = scheme.foreground } },
	-- 		{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
	-- 	}),
	-- 	inactive_tab_right = wezterm.format({
	-- 		{ Background = { Color = scheme.background } },
	-- 		{ Foreground = { Color = scheme.foreground } },
	-- 		{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
	-- 	}),
	-- }
end

function module.apply(config)
	config.window_padding = {
		top = 0,
		bottom = 0,
	}

	config.window_decorations = "NONE"

	config.enable_scroll_bar = false
	config.scrollback_lines = 5000

	config.cursor_blink_rate = 0

	apply_tab_bar(config)
end

return module
