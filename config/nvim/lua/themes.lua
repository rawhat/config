local M = {}

M.themes = {
	tokyonight = {
		package = "folke/tokyonight.nvim",
		package_name = "tokyonight.nvim",
		name = "tokyonight",
		color_palette = function(palette)
			local colors = require("tokyonight.colors").setup()
			return colors
		end,
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
		color_palette = function(palette)
			local variant = palette or "duskfox"
			return require("nightfox.palette").load(variant)
		end,
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
			vim.cmd.colorscheme("kanagawa")
		end,
	},
	catppuccin = {
		package = "catppuccin/nvim",
		package_name = "catppuccin",
		name = "catppuccin",
		color_palette = function(palette)
			local variant = palette or "latte"
			local colors = require("catppuccin.palettes").get_palette(variant)
			return {
				fg0 = colors.text,
				bg0 = colors.surface0,
				blue = {
					base = colors.blue,
				},
				red = {
					base = colors.red,
				},
				green = {
					base = colors.green,
				},
				magenta = {
					base = colors.mauve,
				},
				orange = {
					base = colors.peach,
				},
				yellow = {
					base = colors.yellow,
				},
				pink = {
					base = colors.pink,
				},
				cyan = {
					base = colors.teal,
				},
				white = {
					base = colors.crust,
				},
			}
		end,
		config = function(palette)
			local variant = palette or "latte"
			vim.g.catppuccin_flavour = variant
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
		color_palette = function()
			local colors = require("nordic.colors")
			return {
				fg0 = colors.fg,
				-- this is used for lualine, and i want something to differentiate
				-- since i'm swapping bg to black below
				-- bg0 = colors.bg,
				bg0 = colors.gray1,
				blue = {
					base = colors.blue.base,
				},
				red = {
					base = colors.red.base,
				},
				green = {
					base = colors.green.base,
				},
				magenta = {
					base = colors.magenta.base,
				},
				orange = {
					base = colors.orange.base,
				},
				yellow = {
					base = colors.yellow.base,
				},
				pink = {
					base = colors.red.dim,
				},
				cyan = {
					base = colors.cyan.base,
				},
				white = {
					base = colors.white1,
				},
			}
		end,
		config = function()
			local colors = require("nordic.colors")
			require("nordic").load({
				telescope = {
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

-- M.current_theme = M.themes["catppuccin"]
-- M.current_theme.palette = "mocha"
-- M.current_theme = M.themes["nightfox"]
M.current_theme = M.themes["nordic"]
-- M.current_theme.palette = "dawnfox"
-- M.current_theme = M.themes["embark"]
-- M.current_theme = M.themes["tundra"]

return M
