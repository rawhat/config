return {
	"s1n7ax/nvim-window-picker",
	keys = {
		{
			"<leader>m",
			desc = "Jump to window",
			function()
				local window = require("window-picker").pick_window()
				if window ~= nil then
					vim.api.nvim_set_current_win(window)
				end
			end,
		},
	},
	config = function()
		require("window-picker").setup({
			hint = "floating-big-letter",
			selection_chars = "asdfqwerghzxcv",
			show_prompt = false,
			filter_rules = {
				bo = {
					filetype = { "notify", "incline" },
				},
			},
		})
	end,
}
