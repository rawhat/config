return {
	"mrjones2014/legendary.nvim",
	dependencies = { "folke/which-key.nvim", "nvim-telescope/telescope.nvim" },
	priority = 10000,
	lazy = false,
	keys = {
		{ "<leader>wk", desc = "Search keybinds, commands, autocommands", "<cmd>Legendary keymaps<cr>" },
	},
	config = function()
		require("legendary").setup({
			extensions = {
				lazy_nvim = {
					auto_register = true,
				},
				which_key = {
					auto_register = true,
				},
			},
		})
	end,
}
