return {
	{ "kchmck/vim-coffee-script", ft = "coffee" },
	{ "mtscout6/vim-cjsx", ft = "coffee" },
	{ "chrisbra/csv.vim", ft = "csv" },
	{
		"google/vim-jsonnet",
		ft = { "libsonnet", "jsonnet" },
		config = function()
			vim.cmd([[autocmd BufRead,BufNewFile *.libsonnet set filetype=jsonnet]])
		end,
	},
	{ "mattn/emmet-vim", ft = { "html", "typescriptreact", "javascriptreact" } },
}
