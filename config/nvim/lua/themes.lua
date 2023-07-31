local M = {}

M.themes = {
	tokyonight = {
		package = "folke/tokyonight.nvim",
		package_name = "tokyonight.nvim",
		name = "tokyonight",
		config = function()
			vim.g.tokyonight_sidebars = {
				-- "which-key",
				"toggleterm",
				"packer.nvim",
			}
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
	nord = {
		package = "shaunsingh/nord.nvim",
		package_name = "nord.nvim",
		name = "nord",
		config = function()
			vim.g.nord_contrast = true
			require("nord").set()
		end,
	},
	ayu = {
		package = "Shatur/neovim-ayu",
		package_name = "neovim-ayu",
		name = "ayu",
		config = function()
			vim.g.ayu_mirage = true
			vim.cmd.colorscheme("ayu")
		end,
	},
	nightfly = {
		package = "bluz71/vim-nightfly-guicolors",
		package_name = "vim-nightfly-guicolors",
		name = "nightfly",
		config = function() end,
	},
	neon = {
		package = "rafamadriz/neon",
		package_name = "neon",
		name = "neon",
		config = function()
			-- "default", "dark", "doom"
			vim.g.neon_style = "dark"
			vim.cmd.colorscheme("neon")
		end,
	},
	github = {
		package = "projekt0n/github-nvim-theme",
		package_name = "github-nvi-theme",
		name = "github",
		config = function()
			require("github-theme").setup()
		end,
	},
	nightfox = {
		package = "EdenEast/nightfox.nvim",
		package_name = "nightfox.nvim",
		name = "nightfox",
		config = function(palette)
			local variant = palette or "duskfox"
			local nightfox = require("nightfox")
			nightfox.setup({
				groups = {
					all = {
						["@constructor"] = { link = "@tag" },
					},
				},
				options = {
					styles = { comments = "italic" },
					modules = {
						cmp = true,
						diagnostic = true,
						gitsigns = true,
						hop = true,
						modes = true,
						native_lsp = {
							enable = true,
							background = true,
						},
						nvimtree = true,
						telescope = true,
						treesitter = true,
						whichkey = true,
					},
				},
			})
			vim.cmd("colorscheme " .. variant)
		end,
	},
	kanagawa = {
		package = "rebelot/kanagawa.nvim",
		package_name = "kanagawa.nvim",
		name = "kanagawa",
		config = function()
			require("kanagawa").setup({
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	catppuccin = {
		package = "catppuccin/nvim",
		package_name = "catppuccin",
		name = "catppuccin",
		config = function(palette)
			local variant = palette or "mocha"
			require("catppuccin").setup({
				flavour = palette or "mocha",
				custom_highlights = function(colors)
					return {
						cjsxElement = { link = "@constructor" },
						cjsxAttribProperty = { link = "@tag.attribute" },
						MatchParenCur = { fg = colors.yellow, style = { "bold" } },
						MatchParen = { bg = colors.base, fg = colors.yellow, style = { "bold" } },
						LspInlayHint = { link = "Comment" },
					}
				end,
				integrations = {
					cmp = true,
					flash = true,
					gitsigns = true,
					hop = true,
					indent_blankline = {
						enabled = true,
					},
					lsp_trouble = true,
					markdown = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
						inlay_hints = {
							background = true,
						},
					},
					noice = true,
					symbols_outline = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	everforest = {
		package = "sainnhe/everforest",
		package_name = "everforest",
		name = "everforest",
		config = function()
			vim.opt.background = "light"
			vim.g.everforest_background = "hard"
			vim.g.everforest_better_performance = 1
			vim.cmd.colorscheme("everforest")
		end,
	},
	embark = {
		package = "embark-theme/vim",
		package_name = "embark",
		name = "embark",
		config = function()
			vim.cmd.colorscheme("embark")
		end,
	},
	tundra = {
		package = "sam4llis/nvim-tundra",
		package_name = "tundra",
		name = "tundra",
		config = function()
			vim.opt.background = "dark"
			vim.cmd.colorscheme("tundra")
		end,
	},
	nordic = {
		package = "AlexvZyl/nordic.nvim",
		package_name = "nordic",
		name = "nordic",
		config = function()
			local colors = require("nordic.colors")
			require("nordic").load({
				telescope = {
					style = "classic",
				},
				noice = {
					style = "classic",
				},
				override = {
					HopNextKey = {
						fg = colors.cyan.base,
						bold = true,
					},
					HopNextKey1 = {
						fg = colors.red.base,
						bold = true,
					},
					HopNextKey2 = {
						fg = colors.blue2,
					},
					HopUnmatched = {
						fg = colors.yellow.dim,
					},
					Normal = {
						bg = colors.bg_dark,
					},
					NormalNC = {
						bg = colors.bg_dark,
					},
					Cursorline = {
						bg = colors.bg,
					},
					TelescopePromptNormal = {
						bg = colors.bg,
					},
					TelescopeResultsNormal = {
						bg = colors.bg,
					},
					TelescopePreviewNormal = {
						bg = colors.bg,
					},
					GitSignsAdd = {
						bg = colors.bg_dark,
					},
					GitSignsChange = {
						bg = colors.bg_dark,
					},
					GitSignsDelete = {
						bg = colors.bg_dark,
					},
					SignColumn = {
						bg = colors.bg_dark,
					},
					ModesCopy = {
						bg = colors.yellow.base,
					},
					ModesDelete = {
						bg = colors.red.base,
					},
					ModesInsert = {
						bg = colors.cyan.base,
					},
					ModesVisual = {
						bg = colors.magenta.base,
					},
					WinSeparator = {
						fg = colors.fg,
						bg = colors.bg_dark,
					},
					TelescopeBorder = {
						fg = colors.gray1,
						bg = colors.bg,
					},
				},
			})
		end,
	},
}

-- M.current_theme = M.themes["kanagawa"]
M.current_theme = M.themes["catppuccin"]
M.current_theme.palette = "mocha"
-- M.current_theme = M.themes["nightfox"]
-- M.current_theme = M.themes["nordic"]
-- M.current_theme.palette = "dawnfox"
-- M.current_theme = M.themes["embark"]
-- M.current_theme = M.themes["tundra"]

return M
