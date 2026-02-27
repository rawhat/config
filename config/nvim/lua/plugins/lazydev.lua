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
				{ path = "wezterm-types", mods = { "wezterm" } },
			}
			if vim.fn.has("macunix") == 1 then
				table.insert(libraries, { path = os.getenv("HOME") .. ".local/share/sketchybar_lua/" })
			end
			return {
				library = libraries,
			}
		end,
	},
}
