local config = require("kommentary.config")

local just_double_slash = {
	single_line_comment_strings = "//",
	multi_line_comment_strings = false,
}

local just_hash = {
	single_line_comment_strings = "#",
	prefer_single_line_comments = true,
}

config.configure_language("fish", just_hash)

config.configure_language("zig", just_double_slash)

config.configure_language("go", just_double_slash)
