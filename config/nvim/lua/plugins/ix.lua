return {
	"hrsh7th/nvim-ix",
	dependencies = {
		"hrsh7th/nvim-cmp-kit",
		"onsails/lspkind.nvim",
	},
	config = function()
		-- vim.o.winborder = "rounded"

		local ix = require("ix")

		ix.setup({
			signature_help = {
				auto = false,
			},
			expand_snippet = vim.snippet.expand,
			attach = {
				insert_mode = function()
					if vim.bo.buftype == "nofile" or vim.bo.buftype == "prompt" then
						return
					end
					do
						local service = ix.get_completion_service({ recreate = true })
						service:register_source(ix.source.completion.github(), { group = 1 })
						service:register_source(ix.source.completion.calc(), { group = 1 })
						service:register_source(ix.source.completion.emoji(), { group = 1 })
						service:register_source(ix.source.completion.path(), { group = 10 })
						ix.source.completion.attach_lsp(service, {
							default = {
								group = 20,
								priority = 1,
							},
							servers = {},
						})
						service:register_source(ix.source.completion.buffer(), { group = 30, dedup = true })
					end
					do
						local service = ix.get_signature_help_service({ recreate = true })
						ix.source.signature_help.attach_lsp(service)
					end
				end,
			},
		})

		vim.keymap.set({ "i", "c" }, "<C-n>", ix.action.completion.select_next())
		vim.keymap.set({ "i", "c" }, "<C-p>", ix.action.completion.select_prev())

		ix.charmap.set({ "i", "c" }, "<Tab>", ix.action.completion.commit({ select_first = true, replace = true }))
		ix.charmap.set({ "i", "c" }, "<C-e>", ix.action.completion.close())
		ix.charmap.set({ "c" }, "<CR>", ix.action.completion.commit_cmdline())
	end,
}
