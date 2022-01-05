local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	error("Couldn't load treesitter")
	return
end

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.gleam = {
	install_info = {
		url = "~/gleams/tree-sitter-gleam",
		files = { "src/parser.c" },
	},
	filetype = "gleam",
}

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
})
