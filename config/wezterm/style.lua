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
	config.tab_max_width = 64
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
			{ Text = " " },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = wezterm.nerdfonts.ple_left_half_circle_thick },
			{ Background = { Color = foreground } },
			{ Foreground = { Color = background } },
			{ Text = tab.active_pane.title .. " " },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = wezterm.nerdfonts.ple_right_half_circle_thick },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = " " },
		}
	end)
	wezterm.on("update-status", function(gui_window, pane)
		local is_one_pane = #pane:tab():panes() == 1
		local overrides = gui_window:get_config_overrides() or {}
		if is_one_pane and string.match(pane:get_foreground_process_name(), "nvim") then
			overrides.enable_tab_bar = false
		else
			overrides.enable_tab_bar = true
		end

		local tabs = gui_window:mux_window():tabs()
		local mid_width = 0
		for idx, tab in ipairs(tabs) do
			local title = tab:get_title()
			mid_width = mid_width + math.floor(math.log(idx, 10)) + 1
			mid_width = mid_width + 2 + #title + 1
		end
		local tab_width = gui_window:active_tab():get_size().cols
		local max_left = tab_width / 2 - mid_width / 2

		gui_window:set_left_status(wezterm.pad_left(" ", max_left))
		gui_window:set_right_status("")

		gui_window:set_config_overrides(overrides)
	end)
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
