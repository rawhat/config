local config = require("kommentary.config")

config.configure_language("zig", {
	single_line_comment_strings = "//",
	multi_line_comment_strings = false,
})
