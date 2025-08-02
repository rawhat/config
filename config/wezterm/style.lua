local wezterm = require("wezterm")
local font = require("fonts")
local colors = require("colors")

local module = {}

local function re_center_status(window, pane)
	local tabs = window:mux_window():tabs()
	local tab_width = 0
	for _, tab in pairs(tabs) do
		wezterm.log_info(tab:tab_id(), tab:get_title())
		tab_width = tab_width + #tab:get_title()
	end
	local cols = window:active_tab():get_size().cols

	local half_of_tab_width = math.floor(tab_width / 2)
	local half_of_col_width = math.floor(cols / 2)
	wezterm.log_info(tab_width, cols)
	wezterm.log_info("active title: ", window:active_tab():get_title())

	-- Magic number :(
	local max_left = half_of_col_width - (half_of_tab_width + math.floor(6.5 * #tabs))

	window:set_left_status(wezterm.pad_left(" ", max_left))
	window:set_right_status("")
end

local function toggle_tab_bar(window, pane)
	local tab = pane:tab()
	if not tab then
		return
	end
	local panes = tab:panes()
	wezterm.log_info(panes)
	local is_one_pane = panes and #panes == 1
	local overrides = window:get_config_overrides() or {}
	if is_one_pane and string.match(pane:get_foreground_process_name(), "nvim") then
		overrides.enable_tab_bar = false
	else
		overrides.enable_tab_bar = true
	end

	window:set_config_overrides(overrides)
end

local function format_tab_title(tab, hover, scheme)
	local active_color = "#DCA561"
	local active_text = "#181820"
	local edge_background = scheme.background
	local edge_foreground = tab.is_active and active_color or scheme.foreground
	local background = tab.is_active and active_color or scheme.foreground
	local foreground = tab.is_active and active_text or scheme.background
	return {
		{ Background = { Color = scheme.background } },
		{ Foreground = { Color = scheme.foreground } },
		{ Text = " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = tab.active_pane.title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
		{ Background = { Color = scheme.background } },
		{ Foreground = { Color = scheme.foreground } },
		{ Text = " " },
	}
end

local function apply_tab_bar(config)
	local scheme = wezterm.color.get_builtin_schemes()[colors.color_scheme]
	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 64
	config.inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	}
	config.window_frame = {
		font = wezterm.font({ family = font.current_font, weight = "Bold" }),
	}
	config.colors = {
		tab_bar = {
			background = scheme.background,
		},
	}
	wezterm.on("format-tab-title", function(tab, tabs, panes, configuration, hover, max_width)
		return format_tab_title(tab, hover, scheme)
	end)
	wezterm.on("update-status", function(window, pane)
		re_center_status(window, pane)
		toggle_tab_bar(window, pane)
	end)
	wezterm.on("re-center_status", re_center_status)
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
