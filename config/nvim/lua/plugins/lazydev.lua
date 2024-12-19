return {
	{
		"folke/lazydev.nvim",
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		ft = "lua",
		config = function()
			local libraries = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			}
			if vim.fn.has("macunix") == 1 then
				table.insert(libraries, { path = "/Users/amanning/.local/share/sketchybar_lua/" })
			end
			require("lazydev").setup({
				library = libraries,
			})
		end,
	},
}
