local theme = require("themes").current_theme

return {
	theme.package,
	lazy = false,
	priority = 1000,
	name = theme.name,
	config = function()
		-- clear LSP semantic highlight tokens
		vim.api.nvim_create_autocmd("Colorscheme", {
			desc = "Clear LSP highlight groups",
			callback = function()
				for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
					vim.api.nvim_set_hl(0, group, {})
				end
			end,
		})
		theme.config(theme.palette)
	end,
}
