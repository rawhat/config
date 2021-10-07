local ls = require("luasnip")

ls.snippets = {
	bzl = {
		ls.parser.parse_snippet(
			{ trig = "npm_install" },
			[[npm_install(
    name = "$1",
    version = "$2",
    sha256 = "$3",
)]]
		),
		ls.parser.parse_snippet(
			{ trig = "npm_type_install" },
			[[npm_install(
    name = "$1",
    version = "$2",
    sha256 = "$3",
    type_version = "$4",
    type_sha256 = "$5",
)]]
		),
	},
}

require("luasnip/loaders/from_vscode").lazy_load()
