return {
	"saghen/blink.cmp",
	lazy = false,
	build = "cargo build --release",
	opts = {
		keymap = {
			select_prev = { "<C-p>" },
			select_next = { "<C-n>" },
		},
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		trigger = {
			signature_help = {
				enabled = true,
			},
		},
		highlight = {
			use_npm_cmp_as_default = true,
		},
		sources = {
			providers = {
				{
					{ "blink.cmp.sources.lsp" },
					{ "blink.cmp.sources.path" },
				},
				{
					{ "blink.cmp.sources.buffer" },
				},
			},
		},
		--[[ fuzzy = {
			prebuiltBinaryies = {
				download = true,
				forceVersion = "main",
			},
		}, ]]
	},
}
