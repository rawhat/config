return {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	keys = {
		{ "<leader>gd", desc = "Git diff this", "<cmd>Gitsigns diffthis<cr>" },
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
		{ "<leader>gb", desc = "Open git blame", "<cmd>Gitsigns blame<cr>" },
	},
	config = function()
		require("gitsigns").setup({
			trouble = true,
		})

		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = { "gitsigns.blame" },
			callback = function()
				vim.keymap.set("n", "q", function()
					vim.api.nvim_buf_delete(0, {})
				end, { buffer = true })
			end,
		})
	end,
}
