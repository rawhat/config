return {
	"luukvbaal/statuscol.nvim",
	branch = "0.10",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			bt_ignore = { "terminal", "nofile" },
			relculright = true,
			segments = {
				{ sign = { name = { "Diagnostic" } }, maxwidth = 2, auto = true },
				{ text = { builtin.lnumfunc } },
				{ sign = { namespace = { "gitsigns" } }, maxwidth = 1, colwidth = 1, auto = true },
			},
		})
	end,
}
