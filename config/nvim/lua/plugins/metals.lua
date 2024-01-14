return {
	"scalameta/nvim-metals",
	config = function()
		local present, metals = pcall(require, "metals")

		if not present then
			error("No metals :(")
			return
		end

		vim.cmd([[
  augroup lsp
    au!
    au FileType scala,sbt lua require("metals").initialize_or_attach({})
  augroup end
]])

		METALS_CONFIG = metals.bare_config()
		METALS_CONFIG.init_options.statusBarProvider = "on"
	end,
}
