return {
	"saghen/blink.cmp",
	lazy = false,
	build = "cargo build --release",
	opts = {
		appearance = {
			use_nvim_cmp_as_default = true,
		},
		keymap = {
			preset = "super-tab",
		},
		completion = {
			trigger = {
				show_in_snippet = false,
			},
			documentation = {
				auto_show = true,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallback = { "lsp" } },
			},
		},
	},
}
