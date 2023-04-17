require("lualine").setup({
	options = {
		component_separators = "",
		section_separators = "",
		theme = "kanagawa",
	},
	extensions = {
		"fugitive",
		"lazy",
		"nvim-tree",
		"quickfix",
		"symbols-outline",
		"toggleterm",
		"trouble",
	},
	sections = {
		lualine_a = {
			{
				"filename",
				path = 1,
			},
		},
		lualine_b = {
			"progress",
		},
		lualine_c = {
			{ "diagnostics", symbols = { error = " ", warn = " ", info = " " } },
		},
		lualine_x = {
			{
				function()
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					local client_names = {}
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							table.insert(client_names, client.name)
						end
					end
					return table.concat(client_names, "|")
				end,
				cond = function()
					return next(vim.lsp.get_active_clients()) ~= nil
				end,
				icons_enabled = true,
				icon = "",
			},
		},
		lualine_y = {
			{ "diff", symbols = { added = " ", modified = "柳", removed = " " } },
		},
		lualine_z = {
			"branch",
		},
	},
})
