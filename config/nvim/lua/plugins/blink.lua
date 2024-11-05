return {
	"saghen/blink.cmp",
	lazy = false,
	build = "cargo build --release",
	opts = {
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		keymap = {
			preset = "super-tab",
		},
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			},
		},
		trigger = {
			completion = {
				show_in_snippet = false,
			},
		},
		windows = {
			autocomplete = {
				draw = "minimal",
			},
			documentation = {
				auto_show = true,
			},
		},
	},
}
