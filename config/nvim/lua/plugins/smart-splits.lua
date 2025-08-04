return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	opts = {
		multiplexer_itegration = "wezterm",
		at_edge = "stop",
	},
	keys = function()
		local os_name = vim.uv.os_uname()
		local mod = function(other)
			return "<A-" .. other .. ">"
		end
		-- if os_name.sysname == "Darwin" then
		-- 	mod = function(other)
		-- 		return "<M-" .. other .. ">"
		-- 	end
		-- end
		-- vim.print(os_name)

		return {
			{
				mod("h"),
				desc = "Move left",
				function()
					require("smart-splits").move_cursor_left()
				end,
			},
			{
				mod("j"),
				desc = "Move down",
				function()
					require("smart-splits").move_cursor_down()
				end,
			},
			{
				mod("k"),
				desc = "Move up",
				function()
					require("smart-splits").move_cursor_up()
				end,
			},
			{
				mod("l"),
				desc = "Move right",
				function()
					require("smart-splits").move_cursor_right()
				end,
			},
			{
				"<C-l>",
				desc = "Resize right",
				function()
					require("smart-splits").resize_right()
				end,
			},
			{
				"<C-k>",
				desc = "Resize up",
				function()
					require("smart-splits").resize_up()
				end,
			},
			{
				"<C-j>",
				desc = "Resize down",
				function()
					require("smart-splits").resize_down()
				end,
			},
			{
				"<C-h>",
				desc = "Resize left",
				function()
					require("smart-splits").resize_left()
				end,
			},
		}
	end,
}
