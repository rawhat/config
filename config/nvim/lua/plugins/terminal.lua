return {
	"rebelot/terminal.nvim",
	keys = {
		{
			"<leader>tr",
			desc = "<r>run command in split term",
			function()
				require("terminal").run(nil, {
					layout = { open_cmd = "botright vertical new" },
				})
			end,
		},
	},
	config = function()
		require("terminal").setup()
		vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
			callback = function(args)
				if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
					vim.cmd("startinsert")
				end
			end,
		})
	end,
}
