local wezterm = require("wezterm")
local font = require("fonts")
local colors = require("colors")
local domain = require("domain")

local module = {}

local tab_max_width = 64

-- thanks @mrjones2014 !
local function tab_title(tab, is_mux_win)
	local title

	if is_mux_win then
		title = tab:get_title()
	else
		title = tab.tab_title
	end

	if title and #title > 0 then
		return title
	end

	-- remove hostname

	if is_mux_win then
		title = tab:window():gui_window():active_pane():get_title()
	else
		title = tab.active_pane.title
	end

	return string.gsub(title, "^%[?[%a%d\\-]%]? ", "")
end

local function format_tab_title(tab, idx, max_width, is_mux_win)
	-- 6 because of the two spaces below, plus 2 separators, plus tab index

	return string.format(" %d %s ", idx, wezterm.truncate_left(tab_title(tab, is_mux_win), max_width - 6))
end

local function re_center_status(window, pane)
	local mux_win = window:mux_window()

	local total_width = mux_win:active_tab():get_size().cols

	-- local all_tabs = mux_win:tabs()
	--
	-- local tabs_max_width = tab_max_width * #all_tabs

	local tabs_total_width = 0

	for _, tab in ipairs(mux_win:tabs()) do
		tabs_total_width = tabs_total_width + #format_tab_title(tab, 0, tab_max_width, true) + 6
	end

	window:set_left_status(string.rep(" ", math.floor((total_width / 2) - (tabs_total_width / 2))))
end

local function toggle_tab_bar(window, pane)
	local tab = pane:tab()
	if not tab then
		return
	end
	local panes = tab:panes()
	local is_one_pane = panes and #panes == 1
	local overrides = window:get_config_overrides() or {}
	local foreground_process = pane:get_foreground_process_name()
	if is_one_pane and foreground_process and string.match(foreground_process, "nvim") then
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

	if domain.platform() == "macos" then
		config.window_decorations = "RESIZE"
	else
		config.window_decorations = "NONE"
	end

	config.enable_scroll_bar = true
	config.scrollback_lines = 50000

	config.cursor_blink_rate = 0

	apply_tab_bar(config)
end

return module
