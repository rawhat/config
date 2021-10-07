local config = require("kommentary.config")

local just_double_slash = {
	single_line_comment_strings = "//",
	multi_line_comment_strings = false,
}

config.configure_language("zig", just_double_slash)

config.configure_language("go", just_double_slash)
