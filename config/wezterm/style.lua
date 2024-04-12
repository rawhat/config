local module = {}

function module.apply(config)
	config.window_padding = {
		top = 0,
		bottom = 0,
	}

	config.window_decorations = "RESIZE"

	config.enable_scroll_bar = false
	config.scrollback_lines = 5000

	config.enable_tab_bar = false

	config.cursor_blink_rate = 0
end

return module
