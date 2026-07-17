return {
	"saghen/blink.pairs",
	dependencies = { "saghen/blink.lib" },
	-- version = "*",
	build = function()
		require("blink.pairs").build():pwait(60000)
	end,
	opts = {},
}

-- return {
-- 	"windwp/nvim-autopairs",
-- 	event = "InsertEnter",
-- 	opts = {
-- 		check_ts = true,
-- 		enable_check_bracket_line = true,
-- 	},
-- }
