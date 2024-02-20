return {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	keys = {
		{ "<leader>gd", desc = "Git diff this", "<cmd>Gitsigns diffthis<cr>" },
		{ "<leader>gb", desc = "Git blame line", "<cmd>Gitsigns blame_line<cr>" },
		{
			"<leader>gf",
			desc = "Git diff something",
			function()
				vim.ui.input({ prompt = "Branch to diff against" }, function(search)
					if search ~= "" then
						vim.cmd.Gitsigns("diffthis " .. search)
					end
				end)
			end,
		},
	},
	config = function()
		require("gitsigns").setup({
			trouble = true,
		})
	end,
}
