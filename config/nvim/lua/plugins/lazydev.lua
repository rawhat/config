return {
	{
		"folke/lazydev.nvim",
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		ft = "lua",
		opts = function()
			local libraries = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			}
			if vim.fn.has("macunix") == 1 then
				table.insert(libraries, { path = "/Users/amanning/.local/share/sketchybar_lua/" })
			end
			return {
				library = libraries,
			}
		end,
	},
}
