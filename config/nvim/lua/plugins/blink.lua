return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.lib",
	},
	build = function()
		require("blink.cmp").build():wait(60000)
	end,
	-- enabled = false,
	opts = {
		keymap = {
			preset = "super-tab",
		},
		cmdline = {
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":" or vim.fn.getcmdtype() == "@"
					end,
				},
			},
			keymap = {
				["<Tab>"] = { "show", "accept" },
			},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = false,
				},
				resolve_timeout_ms = 10000,
			},
			keyword = {
				range = "full",
			},
			trigger = {
				show_in_snippet = false,
				show_on_backspace_in_keyword = true,
			},
			documentation = {
				auto_show = true,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},
			providers = {
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
				lsp = { fallbacks = {} },
				path = {
					opts = {
						get_cwd = function(_)
							return vim.fn.getcwd()
						end,
					},
				},
			},
		},
	},
}
