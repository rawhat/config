local ls = require("luasnip")

ls.config.set_config({
	history = true,
	region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave",
})

ls.add_snippets("bzl", {
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
})

ls.add_snippets("gleam", {
	ls.parser.parse_snippet(
		{ trig = "pub fn" },
		[[pub fn $1($2) -> $3 {
  $4
}]]
	),
	ls.parser.parse_snippet(
		{ trig = "fn" },
		[[fn $1($2) -> $3 {
  $4
}]]
	),
	ls.parser.parse_snippet(
		{ trig = "pub type" },
		[[pub type $1 {
  $2
}]]
	),
	ls.parser.parse_snippet(
		{ trig = "type" },
		[[type $1 {
  $2
}]]
	),
	ls.parser.parse_snippet({ trig = "im" }, [[import $1]]),
})

ls.add_snippets("bzl", {
	ls.parser.parse_snippet(
		{ trig = "ts_library" },
		[[ts_library(
    name = "$1",
    srcs = ["$2"],
    tsc_config = "//:ts_config_strict",
    deps = [
      "$3",
    ],
)]]
	),
})

require("luasnip.loaders.from_vscode").lazy_load()
