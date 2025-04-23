return {
	"saghen/blink.cmp",
	lazy = false,
	build = "cargo build --release",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		fuzzy = {
			sorts = { "exact", "score", "sort_text" },
		},
		keymap = {
			preset = "super-tab",
		},
		completion = {
			accept = {
				resolve_timeout_ms = 10000,
			},
			keyword = {
				range = "full",
			},
			trigger = {
				show_in_snippet = false,
			},
			documentation = {
				auto_show = true,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
				lsp = { fallbacks = {} },
			},
		},
	},
}
