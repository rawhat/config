return {
	"rebelot/heirline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local heirline = require("heirline")
		local utils = require("heirline.utils")
		local conditions = require("heirline.conditions")

		local theme = require("themes").current_theme

		local colors = theme.heirline_colors(theme.palette)

		local mode_colors = colors.modes

		local Filename = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			utils.surround({ " ", " " }, nil, {
				provider = function()
					local path = vim.fn.expand("%:~:.")
					if path == "" then
						return " [No Name] "
					end
					return " " .. path .. " "
				end,
			}),
			hl = function(self)
				return { bg = mode_colors[self.mode], fg = "fg1", bold = true }
			end,
		}

		local Progress = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			utils.surround({ " ", " " }, nil, {
				provider = function()
					local progress = vim.api.nvim_eval_statusline("%p", {})
					local str = tonumber(progress["str"]) or ""
					if str == "" or str == 0 then
						return "Top"
					end
					if str == 100 then
						return "Bot"
					end
					return string.format("%2d", str) .. "%%"
				end,
			}),
			hl = function(self)
				return {
					bg = "bg1",
					fg = mode_colors[self.mode],
				}
			end,
		}

		local Diagnostics = {
			condition = conditions.has_diagnostics,
			static = {
				error_icon = " ",
				warn_icon = " ",
				info_icon = " ",
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { "DiagnosticChanged", "BufEnter" },
			hl = { bg = "bg0", fg = "white" },
			utils.surround({ " ", " " }, nil, {
				{
					provider = function(self)
						return self.errors > 0 and (self.error_icon .. self.errors .. " ")
					end,
					h1 = { fg = "red" },
				},
				{
					provider = function(self)
						return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
					end,
					hl = { fg = "yellow" },
				},
				{
					provider = function(self)
						return self.info > 0 and (self.info_icon .. self.info .. " ")
					end,
					hl = { fg = "green" },
				},
			}),
		}

		local Separator = {
			provider = "%=",
		}

		local LSP = {
			init = function(self)
				self.filetype = require("utils").get_option_value("filetype", { buf = 0 })
			end,
			condition = function()
				local clients = require("utils").get_lsp_clients()
				for _, _ in pairs(clients or {}) do
					return true
				end
				return false
			end,
			hl = { bg = "bg0", fg = "fg0" },
			utils.surround({ " ", " " }, nil, {
				provider = function(self)
					local clients = require("utils").get_lsp_clients()
					local client_names = {}
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, self.filetype) ~= -1 then
							table.insert(client_names, client.name)
						end
					end
					local formatted = table.concat(client_names, "|")
					return " " .. formatted
				end,
			}),
		}

		local Diff = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
			end,
			hl = {
				bg = "bg1",
				fg = "white",
			},
			utils.surround({ " ", " " }, nil, {
				hl = {
					bg = "bg1",
				},
				{
					provider = function(self)
						return " " .. (self.status_dict.added or 0) .. " "
					end,
					hl = {
						fg = "green",
					},
				},
				{
					provider = function(self)
						return "柳" .. (self.status_dict.changed or 0) .. " "
					end,
					hl = {
						fg = "yellow",
					},
				},
				{
					provider = function(self)
						return " " .. (self.status_dict.removed or 0)
					end,
					hl = {
						fg = "red",
					},
				},
			}),
		}

		local Branch = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.mode = vim.fn.mode(1)
			end,
			hl = function(self)
				return {
					bg = mode_colors[self.mode],
					fg = "fg1",
					bold = true,
				}
			end,
			utils.surround({ " ", " " }, nil, {
				provider = function(self)
					return " " .. self.status_dict.head
				end,
			}),
		}

		heirline.setup({
			statusline = {
				{ Filename, Progress, Diagnostics },
				{ Separator },
				{ LSP, Diff, Branch },
			},
			opts = {
				colors = colors,
			},
		})
	end,
}
