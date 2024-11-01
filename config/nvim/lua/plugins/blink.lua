return {
	"saghen/blink.cmp",
	lazy = false,
	build = "cargo build --release",
	opts = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		keymap = "super-tab",
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
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
