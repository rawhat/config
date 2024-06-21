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
			on_attach = function()
				local windows = vim.api.nvim_list_wins()
				for _, win in pairs(windows) do
					local buf = vim.api.nvim_win_get_buf(win)
					local name = vim.api.nvim_buf_get_name(buf)
					if vim.wo[win].diff and name:find("gitsigns://") ~= nil then
						vim.api.nvim_set_current_win(win)
						vim.keymap.set("n", "q", function()
							vim.api.nvim_win_close(win, false)
						end, { buffer = true })
					end
				end
			end,
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
