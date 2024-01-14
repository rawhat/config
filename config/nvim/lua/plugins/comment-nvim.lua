return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	keys = {
		{
			"<leader>cc",
			desc = "Toggle comment on current line",
			function()
				require("Comment.api").toggle.linewise.current()
			end,
		},
		{
			"<leader>cc",
			mode = { "v" },
			desc = "Toggle comment on visual lines",
			function()
				local func = require("Comment.api").toggle.blockwise
				local ft = vim.bo.filetype
				local comment_strings = require("Comment.ft").get(ft)
				if comment_strings == nil or vim.tbl_count(comment_strings) == 1 then
					func = require("Comment.api").toggle.linewise
				end
				local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
				vim.api.nvim_feedkeys(key, "nx", false)
				func(vim.fn.visualmode())
			end,
		},
	},
	config = function()
		require("ts_context_commentstring").setup({
			languages = {
				gleam = "// %s",
			},
		})
		local ft = require("Comment.ft")
		ft.set("gleam", "//%s")
		require("Comment").setup({
			mappings = false,
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
