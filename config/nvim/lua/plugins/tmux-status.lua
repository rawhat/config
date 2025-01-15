return {
	"christopher-francisco/tmux-status.nvim",
	lazy = true,
	enabled = function()
		return vim.fn.has("win32") ~= 1
	end,
	opts = {},
}
