return {
	"folke/sidekick.nvim",
	keys = {
		{ "<leader>xo", desc = "Open sidekick sidebar", "<cmd>Sidekick cli toggle name=claude<cr>" },
		{ "<leader>xp", desc = "Open sidekick prompt", "<cmd>Sidekick cli prompt name=claude<cr>" },
	},
	opts = {},
}
