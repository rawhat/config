local module = {}

function module.apply(config)
	config.animation_fps = 240
	config.max_fps = 240

	-- temporary
	-- config.front_end = "WebGpu"
	if require("domain").platform == "linux" then
		config.enable_wayland = true
	end

	-- config.freetype_load_flags = "NO_HINTING"
	config.freetype_load_target = "Light"
	config.freetype_render_target = "HorizontalLcd"
	-- freetype_interpreter_version = 40
	config.glyph_cache_image_cache_size = 1024
	config.shape_cache_size = 4096
	config.line_state_cache_size = 4096
	config.line_quad_cache_size = 4096
	config.line_to_ele_shape_cache_size = 4096
	config.mux_output_parser_coalesce_delay_ms = 1
end

return module
