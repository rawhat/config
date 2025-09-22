return {
	{ "nvim-mini/mini.ai", version = false, opts = {} },
	{ "nvim-mini/mini.align", version = false, opts = {} },
	{ "nvim-mini/mini.comment", version = false, opts = {} },
	{ "nvim-mini/mini.pairs", version = false, opts = {} },
	{ "nvim-mini/mini.splitjoin", version = false, opts = {
		mappings = {
			toggle = "J",
		},
	} },
	{ "nvim-mini/mini.surround", version = false, opts = {} },
	{
		"nvim-mini/mini.move",
		version = false,
		opts = {
			mappings = {
				left = "<C-h>",
				right = "<C-l>",
				down = "<C-j>",
				up = "<C-k>",

				line_left = "<C-h>",
				line_right = "<C-l>",
				line_down = "<C-j>",
				line_up = "<C-k>",
			},
		},
	},
}
