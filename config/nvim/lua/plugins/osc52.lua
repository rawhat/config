return {
	"ojroques/nvim-osc52",
	keys = {
		{
			"<leader>y",
			mode = { "v" },
			desc = "Copy text via OSC52",
			function()
				require("osc52").copy_visual()
			end,
		},
	},
	cond = function()
		return not require("utils").has("0.10.0")
	end,
	opts = {},
}
