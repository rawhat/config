return {
	{
		"FabijanZulj/blame.nvim",
		keys = {
			{ "<leader>gb", desc = "Toggle git blame", "<cmd>BlameToggle window<cr>" },
		},
		config = function()
			-- TODO:  this is not scoped to theme
			local scheme = require("kanagawa.colors").setup({ theme = "wave" })
			local theme_colors = {}
			for _, value in ipairs(scheme.palette) do
				table.insert(theme_colors, value)
			end
			local colors = require("utils").shuffle(theme_colors)
			require("blame").setup({
				colors = colors,
			})
		end,
	},
}
