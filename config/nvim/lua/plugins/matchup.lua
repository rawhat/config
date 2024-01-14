return {
	"andymass/vim-matchup",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
	end,
}
