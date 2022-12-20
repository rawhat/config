local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,
			},
		},
		path_display = {
			shorten = {
				len = 4,
				exclude = { -1 },
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("notify")
telescope.load_extension("ui-select")
