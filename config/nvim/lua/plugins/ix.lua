return {
	"hrsh7th/nvim-ix",
	dependencies = {
		"hrsh7th/nvim-cmp-kit",
		"onsails/lspkind.nvim",
	},
	config = function()
		local ix = require("ix")

		ix.setup({
			expand_snippet = vim.snippet.expand,
		})

		vim.keymap.set({ "i", "c" }, "<C-n>", ix.action.completion.select_next())
		vim.keymap.set({ "i", "c" }, "<C-p>", ix.action.completion.select_prev())

		ix.charmap.set({ "i", "c" }, "<Tab>", ix.action.completion.commit({ select_first = true, replace = true }))
		ix.charmap.set({ "i", "c" }, "<C-e>", ix.action.completion.close())

		ix.charmap.set({ "c" }, "<CR>", ix.action.completion.commit_cmdline())
		ix.charmap.set({ "i" }, "<CR>", ix.action.completion.commit({ select_first = true }))
	end,
}
