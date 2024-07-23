return {
	{
		"kchmck/vim-coffee-script",
		config = function()
			vim.filetype.add({
				extension = {
					coffee = "coffee",
				},
			})
		end,
	},
	{ "mtscout6/vim-cjsx", ft = "coffee" },
	{ "chrisbra/csv.vim" },
	{
		"google/vim-jsonnet",
		ft = { "jsonnet", "libsonnet" },
		config = function()
			vim.cmd([[autocmd BufRead,BufNewFile *.libsonnet set filetype=jsonnet]])
		end,
	},
	{ "mattn/emmet-vim", ft = { "astro", "html", "typescriptreact", "javascriptreact" } },
}
