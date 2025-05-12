return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cond = function()
		local cwd = require("utils").cwd()
		return string.find(cwd, "vistar") ~= nil
	end,
	opts = {
		picker = "snacks",
		ssh_aliases = {
			["github.com-work"] = "github.com",
		},
	},
}
