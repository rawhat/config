local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	error("Couldn't load treesitter")
	return
end

treesitter.setup({
	ensure_installed = "all",
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
	matchup = { enable = true },
	autopairs = { enable = true },
	autotag = {
		enable = true,
		enable_close_on_slash = false,
	},
	indent = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
			},
		},
	},
})
