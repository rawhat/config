return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local Rule = require("nvim-autopairs.rule")
		local npairs = require("nvim-autopairs")
		npairs.setup({
			check_ts = true,
		})
		npairs.add_rules({
			Rule(" ", " "):with_pair(function(opts)
				local pair = opts.line:sub(opts.col, opts.col + 1)
				return vim.tbl_contains({ "()", "[]", "{}" }, pair)
			end),
			Rule("( ", " )")
				:with_pair(function()
					return false
				end)
				:with_move(function()
					return true
				end)
				:use_key(")"),
		})
	end,
}
