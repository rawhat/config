local present, _ = pcall(require, "packerInit")
local packer

if present then
	packer = require("packer")
else
	return false
end

local use = packer.use

local themes = {
	tokyonight = {
		package = "folke/tokyonight.nvim",
		package_name = "tokyonight.nvim",
		name = "tokyonight",
		config = function()
			vim.g.tokyonight_style = "night"
			vim.g.tokyonight_sidebars = {
				"which-key",
				"toggleterm",
				"packer.nvim",
			}
			vim.cmd([[colorscheme tokyonight]])
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
			vim.cmd([[colorscheme ayu]])
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
			vim.cmd([[colorscheme neon]])
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
		config = function()
			local nightfox = require("nightfox")
			nightfox.setup({
				-- fox = "palefox",
				-- fox = "nordfox",
				styles = { comments = "italic" },
				hlgroups = {
					-- TSProperty and TSString are the same color... but I don't think
					-- any of the alternate colors (or lightening the existing green)
					-- look very good...
					-- TSString = { fg = "${green_br}" },
				},
			})
			nightfox.load()
		end,
	},
}
Global_theme = themes["nightfox"]

return packer.startup(function()
	use({
		"lewis6991/impatient.nvim",
		after = "packer.nvim",
		rocks = { "mpack" },
		config = function()
			require("impatient")
		end,
	})

	-- COLORSCHEME
	use({
		Global_theme.package,
		after = "packer.nvim",
		config = function()
			Global_theme.config()
		end,
	})

	-- manage packer
	use({ "wbthomason/packer.nvim" })

	-- deps
	use({ "nvim-lua/plenary.nvim" })

	-- LANGUAGES
	-- cs
	use({ "kchmck/vim-coffee-script", ft = "coffee" })
	use({ "mtscout6/vim-cjsx", ft = "coffee" })
	---- crystal
	use({ "rhysd/vim-crystal", ft = "crystal" })
	---- csv
	use({ "chrisbra/csv.vim", ft = "csv" })
	-- ---- fsharp
	use({ "kongo2002/fsharp-vim", ft = "fsharp" })
	---- git
	use({ "tpope/vim-git", event = "BufEnter" })
	---- gleam
	use({ "gleam-lang/gleam.vim", ft = "gleam" })
	---- jsonnet
	use({ "google/vim-jsonnet", ft = "jsonnet" })
	---- nginx
	use({ "chr4/nginx.vim", ft = "nginx" })
	---- nim
	use({ "zah/nim.vim", ft = "nim" })
	---- psql
	use({ "lifepillar/pgsql.vim", ft = "sql" })
	---- proto
	use({ "uarun/vim-protobuf", ft = "protobuf" })
	---- Pug
	use({ "digitaltoad/vim-pug", ft = { "pug", "jade" } })
	---- purescript
	use({ "purescript-contrib/purescript-vim", ft = "purescript" })
	---- reason
	use({ "reasonml-editor/vim-reason-plus", ft = { "reason", "reasonreact" } })
	---- sbt
	use({ "derekwyatt/vim-sbt", ft = "sbt" })
	---- xml
	use({ "amadeus/vim-xml", ft = "xml" })

	-- # general
	-- emmet
	use({ "mattn/emmet-vim", ft = { "html", "typescriptreact", "javascriptreact" } })
	-- * for visual selections
	use({ "nelstrom/vim-visual-star-search", event = "BufEnter" })
	-- :noh on cursor move
	use({ "haya14busa/is.vim", event = "BufEnter" })
	-- run tests
	use({ "janko/vim-test", event = "BufEnter" })
	-- shell commands
	use({ "tpope/vim-eunuch", event = "BufEnter" })

	-- OTHER

	-- displays symbols on site for add/delete/change
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.gitsigns")
		end,
	})

	-- modified status bar
	use({
		"shadmansaleh/lualine.nvim",
		after = Global_theme.package_name,
		config = function()
			require("plugins.lualine")
		end,
	})

	-- fuzzy find
	use({
		"nvim-telescope/telescope.nvim",
		event = "BufEnter",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("plugins.telescope")
		end,
	})

	-- search!
	use({ "mileszs/ack.vim", event = "BufEnter" })

	-- highlights trailing whitespace
	use({ "ntpeters/vim-better-whitespace", event = "BufEnter" })

	-- ez commenting
	use({ "b3nj5m1n/kommentary", event = "BufEnter" })
	-- git good
	use({ "tpope/vim-fugitive", event = "BufEnter" })

	-- (--'happy times'--)
	use({
		"blackCauldron7/surround.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.surround")
		end,
	})
	-- highlight/jump to words
	use({
		"phaazon/hop.nvim",
		config = function()
			require("plugins.hop")
		end,
	})

	-- fancy indent helper
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("plugins.indent-blankline")
		end,
	})
	-- highlights hex colors rgb(200, 200, 200)
	use({ "norcalli/nvim-colorizer.lua", event = "BufEnter" })
	-- displays buffers at the top
	use({
		"ap/vim-buftabline",
		event = "VimEnter",
		config = function()
			require("plugins.buftabline")
		end,
	})
	-- buffers
	use({ "jeetsukumaran/vim-buffergator", event = "VimEnter" })

	use({
		"neovim/nvim-lspconfig",
    requires = { "kabouzeid/nvim-lspinstall" },
		config = function()
			require("plugins.lspconfig")
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		after = "friendly-snippets",
		config = function()
			require("luasnip/loaders/from_vscode").load()
		end,
	})

	use({ "rafamadriz/friendly-snippets" })

	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-nvim-lsp" })

	use({
		"hrsh7th/nvim-cmp",
		after = {
			"cmp-buffer",
			"cmp-nvim-lua",
			"cmp-nvim-lsp",
			"LuaSnip",
			"cmp_luasnip",
			"lspkind-nvim",
		},
		config = function()
			require("plugins.cmp")
		end,
	})

	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })

	use({
		"scalameta/nvim-metals",
		ft = "scala",
		config = function()
			require("plugins.metals")
		end,
	})
	use({
		"folke/trouble.nvim",
		after = Global_theme.package_name,
		config = function()
			require("trouble").setup()
		end,
	})

	-- file type icons
  use({ "kyazdani42/nvim-web-devicons"})

	-- file tree
	use({ "kyazdani42/nvim-tree.lua", cmd = "NvimTreeToggle" })

	-- run things asynchronously
	use({ "skywind3000/asyncrun.vim", event = "BufEnter" })

	-- neovim terminal manager
	use({
		"akinsho/nvim-toggleterm.lua",
		after = Global_theme.package_name,
		config = function()
			require("plugins.toggleterm")
		end,
	})

	-- tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "BufRead",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({ "nvim-treesitter/playground", event = "BufRead" })

	use({
		"andymass/vim-matchup",
		after = "nvim-treesitter",
		config = function()
			vim.cmd([[NoMatchParen]])
		end,
	})

	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-autopairs",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		after = "nvim-treesitter",
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- markdown preview
	use({ "npxbr/glow.nvim", run = ":GlowInstall", ft = "markdown" })

	-- display function signatures while typing
	use({ "ray-x/lsp_signature.nvim", event = "BufEnter" })

	-- show pictograms on completion dropdown
	use({
		"onsails/lspkind-nvim",
		-- event = "InsertEnter",
		config = function()
			require("lspkind").init()
		end,
	})

	-- which key???
	use({
		"folke/which-key.nvim",
		after = Global_theme.package_name,
		config = function()
			require("plugins.which_key")
		end,
	})

	-- hmm... `efm` might be more flexible?
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = { "nvim-lspconfig" },
		requires = { "nvim-lua/plenary.nvim" }, -- , "neovim/nvim-lspconfig" },
		config = function()
			require("plugins.null")
		end,
	})
end)
