return {
	"hedyhli/outline.nvim",
	cmd = { "Outline", "OutlineOpen" },
	opts = {
		outline_window = {
			hide_cursor = true,
		},
	},
	keys = {
		{ "<leader>so", "<cmd>Outline<cr>", desc = "Toggle outline" },
	},
}
