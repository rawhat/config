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
			--[[ list = {
				selection = {
					preselect = false,
					-- auto_insert = false,
				},
			}, ]]
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
			},
		},
	},
}
