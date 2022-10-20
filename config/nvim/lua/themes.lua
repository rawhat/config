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
}

-- M.current_theme = M.themes["catppuccin"]
-- M.current_theme.palette = "mocha"
M.current_theme = M.themes["nightfox"]
-- M.current_theme.palette = "dawnfox"

return M
