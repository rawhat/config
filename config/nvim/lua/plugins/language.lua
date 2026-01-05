return {
	{
		"kchmck/vim-coffee-script",
		init = function()
			vim.filetype.add({
				extension = {
					coffee = "coffee",
				},
			})
		end,
	},
	{ "mtscout6/vim-cjsx", ft = "coffee" },
	{
		"google/vim-jsonnet",
		ft = { "jsonnet", "libsonnet" },
		init = function()
			vim.filetype.add({
				extension = {
					libsonnet = "jsonnet",
				},
			})
		end,
	},
	{ "mattn/emmet-vim", ft = { "astro", "html", "typescriptreact", "javascriptreact" } },
}
