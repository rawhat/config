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
		heirline_colors = function(palette)
			local colors = require("nightfox.palette").load(palette or "nightfox")
			return {
				modes = {
					n = colors.blue.dim,
					i = colors.green.dim,
					c = colors.red.dim,
					v = colors.magenta.dim,
					V = colors.magenta.dim,
				},
				fg0 = colors.fg0,
				fg1 = colors.fg1,
				bg = colors.bg1,
				bg0 = colors.bg0,
				bg1 = colors.bg1,
				bg2 = colors.bg2,
				yellow = colors.yellow.base,
				red = colors.red.base,
				green = colors.green.base,
				white = colors.white.base,
				blue = colors.blue.base,
				dimWhite = colors.white.dim,
			}
		end,
	},
	kanagawa = {
		package = "rebelot/kanagawa.nvim",
		package_name = "kanagawa",
		name = "kanagawa",
		config = function(palette)
			require("kanagawa").setup({
				theme = palette or "wave",
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					return {
						["@lsp.mod.readonly.typescriptreact"] = { link = "@variable" },
						["@lsp.mod.readonly.typescript"] = { link = "@variable" },
						["@type.qualifier"] = { link = "Keyword" },
					}
				end,
			})
			vim.cmd.colorscheme("kanagawa-" .. (palette or "wave"))
		end,
		heirline_colors = function(palette)
			local scheme = require("kanagawa.colors").setup({ theme = palette or "wave" })
			local colors = scheme.palette
			local ui = scheme.theme.ui
			return {
				modes = {
					n = colors.lotusBlue4,
					i = colors.lotusGreen2,
					c = colors.lotusRed2,
					v = colors.lotusViolet4,
					V = colors.lotusViolet4,
				},
				fg0 = colors.fujiWhite,
				fg1 = colors.oldWhite,
				bg = ui.bg,
				bg0 = colors.sumiInk1,
				bg1 = colors.sumiInk4,
				yellow = colors.roninYellow,
				red = colors.samuraiRed,
				green = colors.springGreen,
				white = colors.fujiWhite,
				blue = colors.waveBlue1,
				dimWhite = colors.fujiGray,
				active = colors.autumnYellow,
			}
		end,
	},
	catppuccin = {
		package = "catppuccin/nvim",
		package_name = "catppuccin",
		name = "catppuccin",
		config = function(palette)
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
					hop = true,
					gitsigns = true,
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
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
		heirline_colors = function(palette)
			local colors = require("catppuccin.palettes").get_palette(palette or "mocha")
			return {
				modes = {
					n = colors.blue,
					i = colors.green,
					c = colors.peach,
					v = colors.mauve,
					V = colors.mauve,
				},
				fg0 = colors.text,
				fg1 = colors.mantle,
				bg0 = colors.base,
				bg1 = colors.surface1,
				bg2 = colors.surface0,
				yellow = colors.yellow,
				red = colors.red,
				green = colors.green,
				white = colors.white,
			}
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
			require("nordic").load({
				italic_comments = true,
				telescope = {
					style = "classic",
				},
				noice = {
					style = "classic",
				},
				override = {
					Keyword = { italic = true },
				},
				--[[ override = {
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
				}, ]]
			})
		end,
		heirline_colors = function(_palette)
			local colors = require("nordic.colors")
			return {
				modes = {
					n = colors.blue0,
					i = colors.green.dim,
					c = colors.red.dim,
					v = colors.magenta.dim,
					V = colors.magenta.dim,
				},
				fg0 = colors.white1,
				fg1 = colors.white2,
				bg = colors.gray0,
				bg0 = colors.gray1,
				bg1 = colors.gray2,
				yellow = colors.yellow.base,
				red = colors.red.base,
				green = colors.green.base,
				white = colors.white1,
				blue = colors.blue0,
				dimWhite = colors.white0_reduce_blue,
			}
		end,
	},
	rosepine = {
		package = "rose-pine/neovim",
		package_name = "rose-pine",
		name = "rose-pine",
		config = function(palette)
			require("rose-pine").setup({
				variant = palette or "moon",
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	jellybeans = {
		package = "wtfox/jellybeans.nvim",
		package_name = "jellybeans-muted",
		name = "jellybeans",
		config = function(palette)
			require("jellybeans").setup({
				style = palette or "muted",
			})
			vim.cmd("colorscheme jellybeans-" .. (palette or "muted"))
		end,
	},
}

-- M.current_theme = M.themes["rosepine"]
M.current_theme = M.themes["kanagawa"]
-- M.current_theme.palette = "lotus"
--[[ M.current_theme = M.themes["catppuccin"]
M.current_theme.palette = "mocha" ]]
-- M.current_theme = M.themes["nightfox"]
-- M.current_theme = M.themes["nordic"]
-- M.current_theme = M.themes["embark"]
-- M.current_theme = M.themes["tundra"]
-- M.current_theme = M.themes["jellybeans"]

return M
