local present, lualine = pcall(require, "lualine")

if not present then
  error("unable to load lualine")
	return
end

lualine.setup({
	options = { theme = Global_theme.name },
	extensions = { "fzf", "fugitive" },
	sections = {
		lualine_b = { { "branch" }, { "diagnostics", sources = { "nvim_lsp" } } },
		lualine_c = { { "filename", path = 1 } },
	},
})
