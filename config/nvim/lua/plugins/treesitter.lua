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
  -- this has a broken `node-gyp` version, and i'd rather not manage the install
  -- myself for something i don't use
  ignore_install = { "phpdoc" },
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
