local present, _ = pcall(require, "packerInit")
local packer

if present then
	packer = require("packer")
else
	return false
end

local themes = {
	tokyonight = {
		package = "folke/tokyonight.nvim",
		package_name = "tokyonight.nvim",
		name = "tokyonight",
		config = function()
			-- vim.g.tokyonight_style = "night"
			vim.g.tokyonight_sidebars = {
				-- "which-key",
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
				options = {
					styles = { comments = "italic" },
					modules = {
						cmp = true,
						diagnostic = true,
						gitsigns = true,
						hop = true,
						modes = true,
						native_lsp = true,
						nvimtree = true,
						telescope = true,
						treesitter = true,
						whichkey = true,
					},
				},
			})
			vim.cmd("colorscheme duskfox")
		end,
	},
	kanagawa = {
		package = "rebelot/kanagawa.nvim",
		package_name = "kanagawa.nvim",
		name = "kanagawa",
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	catppuccin = {
		package = "catppuccin/nvim",
		package_name = "catppuccin",
		name = "catppuccin",
		config = function()
			-- local catppuccin = require('catppuccin')
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
Global_theme = themes["nightfox"]

return packer.startup(function(use)
	-- manage packer
	use({
		"wbthomason/packer.nvim",
	})

	use({
		"lewis6991/impatient.nvim",
		rocks = { "mpack" },
		config = function()
			_G.__luacache_config = {
				chunks = {
					enable = true,
					path = vim.fn.stdpath("cache") .. "/luacache_chunks",
				},
				modpaths = {
					enable = true,
					path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
				},
			}
			local impatient = require("impatient")
			impatient.enable_profile()
		end,
	})

	-- COLORSCHEME
	use({
		Global_theme.package,
		config = function()
			Global_theme.config()
		end,
	})

	-- deps
	use({
		"nvim-lua/plenary.nvim",
		config = function()
			require("plenary.filetype").add_file("gleam")
		end,
	})

	-- LANGUAGES
	-- faster filetypes?
	use({ "nathom/filetype.nvim" })
	-- cs
	use({ "kchmck/vim-coffee-script", ft = "coffee" })
	use({ "mtscout6/vim-cjsx", ft = "coffee" })
	---- crystal
	use({ "rhysd/vim-crystal", ft = "crystal" })
	---- csv
	use({ "chrisbra/csv.vim", ft = "csv" })
	---- fsharp
	use({ "kongo2002/fsharp-vim", ft = "fsharp" })
	---- git
	use({ "tpope/vim-git" })
	---- gleam
	-- use({ "gleam-lang/gleam.vim", ft = "gleam" })
	---- jsonnet
	use({
		"google/vim-jsonnet",
		ft = { "libsonnet", "jsonnet" },
		config = function()
			vim.cmd([[autocmd BufRead,BufNewFile *.libsonnet set filetype=jsonnet]])
		end,
	})
	-- just
	use({
		"NoahTheDuke/vim-just",
	})
	use({
		"IndianBoy42/tree-sitter-just",
		config = function()
			require("tree-sitter-just").setup({})
		end,
	})
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
	---- rust
	use({
		"simrat39/rust-tools.nvim",
		after = { "nvim-lspconfig" },
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
				},
			})
		end,
	})

	---- sbt
	use({ "derekwyatt/vim-sbt", ft = "sbt" })
	---- xml
	use({ "amadeus/vim-xml", ft = "xml" })

	-- # general
	-- emmet
	use({ "mattn/emmet-vim", ft = { "html", "typescriptreact", "javascriptreact" } })
	-- * for visual selections
	use({ "nelstrom/vim-visual-star-search" })
	-- :noh on cursor move
	use({ "haya14busa/is.vim" })
	-- run tests
	use({ "janko/vim-test" })
	-- shell commands
	use({ "tpope/vim-eunuch" })

	-- OTHER

	-- modified status bar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	})

	-- fuzzy find
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	use("nvim-telescope/telescope-file-browser.nvim")

	-- search!
	use({ "mileszs/ack.vim" })

	-- removes trailing whitespace
	use({ "mcauley-penney/tidy.nvim" })

	-- ez commenting
	use({
		"numToStr/Comment.nvim",
		config = function()
			local ft = require("Comment.ft")
			ft.set("gleam", "//%s")
			require("Comment").setup({
				toggler = {
					line = "<leader>cc",
				},
				opleader = {
					line = "<leader>c",
					block = "<leader>k",
				},
			})
		end,
	})

	-- git good
	use({ "tpope/vim-fugitive" })

	-- (--'happy times'--)
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					insert = "sa",
					visual = "s",
					delete = "sd",
					change = "sc",
				},
			})
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
		config = function()
			require("plugins.indent-blankline")
		end,
	})
	-- highlights hex colors rgb(200, 200, 200)
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"simrat39/rust-tools.nvim",
		},
		after = { "formatter.nvim" },
		config = function()
			require("plugins.lspconfig")
		end,
	})

	use({
		"jose-elias-alvarez/nvim-lsp-ts-utils",
	})

	use({
		"L3MON4D3/LuaSnip",
		after = "friendly-snippets",
		config = function()
			require("plugins.snip")
		end,
	})

	use({ "rafamadriz/friendly-snippets" })

	-- use({ "hrsh7th/cmp-buffer" })
	-- use({ "hrsh7th/cmp-nvim-lua" })
	-- use({ "hrsh7th/cmp-nvim-lsp" })

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
		},
		after = {
			"cmp-buffer",
			"cmp-nvim-lua",
			"cmp-nvim-lsp",
			"LuaSnip",
			"cmp_luasnip",
			"lspkind.nvim",
		},
		config = function()
			require("plugins.cmp")
		end,
	})

	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })

	use({
		"scalameta/nvim-metals",
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
	use({
		"yamatsum/nvim-nonicons",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- file tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		cmd = "NvimTreeToggle",
		config = function()
			require("nvim-tree").setup({})
		end,
	})

	-- run things asynchronously
	use({ "skywind3000/asyncrun.vim" })

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
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})

	use({
		"nvim-treesitter/playground",
	})

	use({
		"andymass/vim-matchup",
		after = "nvim-treesitter",
		config = function()
			vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
		end,
	})

	use({
		"nvim-telescope/telescope-ui-select.nvim",
	})

	use({
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
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
		-- after = "nvim-cmp",
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- markdown preview
	use({
		"ellisonleao/glow.nvim",
		branch = "main",
		run = ":GlowInstall",
		ft = "markdown",
	})

	-- show pictograms on completion dropdown
	use({
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init()
		end,
	})

	-- which key???
	use({
		"folke/which-key.nvim",
		after = { Global_theme.package_name },
	})

	use({
		"mrjones2014/legendary.nvim",
		after = { "which-key.nvim" },
		config = function()
			local wk_options = require("plugins.which_key").options()
			require("which-key").setup(wk_options)

			require("legendary").setup()
			require("plugins.which_key").mappings()
		end,
	})

	-- hmm... `efm` might be more flexible?
	use({ "mhartington/formatter.nvim" })

	-- virtual text types (only in some languages)
	use({
		"jubnzv/virtual-types.nvim",
	})

	-- this doesn't work correctly
	use({
		"yamatsum/nvim-cursorline",
		config = function()
			require("nvim-cursorline").setup({
				cursorline = {
					enable = false,
				},
				cursorword = {
					enable = true,
					min_length = 3,
					hl = { underline = true },
				},
			})
		end,
	})

	-- a nicer quickfix window
	use({
		"https://gitlab.com/yorickpeterse/nvim-pqf.git",
		config = function()
			require("pqf").setup()
		end,
	})

	-- new pop-up???
	use({
		"hood/popui.nvim",
		requires = { "RishabhRD/popfix" },
		config = function()
			vim.ui.select = require("popui.ui-overrider")
		end,
	})

	use({
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup()
		end,
	})

	use({
		"ojroques/vim-oscyank",
		config = function()
			vim.g.oscyank_term = "default"
			vim.cmd([[
          autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif
        ]])
		end,
	})

	use({
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					min_width = { 120 },
				},
			})
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		tag = "release",
		config = function()
			require("gitsigns").setup({
				keymaps = {},
			})
		end,
	})

	use({
		"sudormrfbin/cheatsheet.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	})

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				sources = {
					-- `max_width` doesn't seem to work to limit this?  and the error
					-- message in my `vistar` repo blocks out code
					gopls = {
						ignore = true,
					},
				},
			})
		end,
	})

	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({})
		end,
	})

	use({
		"dstein64/vim-startuptime",
	})

	use({
		"yioneko/nvim-yati",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	})

	use({
		"mrjones2014/smart-splits.nvim",
	})

	use({
		"mvllow/modes.nvim",
		after = { Global_theme.package_name },
		config = function()
			require("modes").setup({
				set_cursor = false,
				set_number = true,
			})
		end,
	})

	use({
		"https://gitlab.com/yorickpeterse/nvim-window.git",
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({})
		end,
	})

	use({
		"b0o/incline.nvim",
		config = function()
			require("incline").setup({
				render = function(props)
					local buffer_name = vim.api.nvim_buf_get_name(props.buf)
					local text = ""
					if buffer_name == "" then
						text = "[No name]"
					else
						text = vim.fn.fnamemodify(buffer_name, ":.")
					end

					return { text, gui = "italic" }
				end,
			})
		end,
	})

	use({
		"MunifTanjim/nui.nvim",
	})

	use({
		"declancm/maximize.nvim",
		config = function()
			require("maximize").setup()
		end,
	})
end)
