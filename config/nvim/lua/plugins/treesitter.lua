local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	error("Couldn't load treesitter")
	return
end

treesitter.setup({
	ensure_installed = "all",
	highlight = { enable = true },
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
	matchup = { enable = true },
	autopairs = { enable = true },
	yati = { enable = true },
})
