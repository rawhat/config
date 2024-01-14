return {
	"b0o/incline.nvim",
	config = function()
		require("incline").setup({
			hide = {
				cursorline = "focused_win",
			},
			render = function(props)
				local buffer_name = vim.api.nvim_buf_get_name(props.buf)
				local text = ""
				if buffer_name == "" then
					text = "[No name]"
				else
					text = vim.fn.fnamemodify(buffer_name, ":.")
				end

				return { text, gui = "italic" }
			end,
		})
	end,
}
