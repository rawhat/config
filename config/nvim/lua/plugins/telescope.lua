local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		dynamic_preview_title = true,
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
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
