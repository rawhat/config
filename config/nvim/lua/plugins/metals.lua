return {
	"scalameta/nvim-metals",
	ft = { "scala", "sbt" },
	opts = function()
		local metals_config = require("metals").bare_config()
		metals_config.init_options.statusBarProvider = "on"
		return metals_config
	end,
	config = function(self, opts)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(opts)
			end,
			group = nvim_metals_group,
		})
	end,
}
