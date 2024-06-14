return {
	{
		"ibhagwan/smartyank.nvim",
		opts = {
			highlight = {
				timeout = 200,
			},
			validate_yank = function()
				return vim.v.operator == "y"
			end,
		},
	},
}
