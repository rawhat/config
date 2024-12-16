return {}
--[[ return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "VimEnter",
	config = function()
		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
				highlight = { "Normal" },
			},
		})
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
	end,
} ]]
