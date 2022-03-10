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
			vim.g.tokyonight_style = "night"
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
				styles = { comments = "italic" },
			})
			nightfox.load()
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
}
Global_theme = themes["nightfox"]

local use = packer.use
return packer.startup({
	function()
		-- manage packer
		use({
			"wbthomason/packer.nvim",
		})

		use({
			"lewis6991/impatient.nvim",
			rocks = { "mpack" },
			config = function()
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
		use({ "nvim-lua/plenary.nvim" })

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
			"windwp/windline.nvim",
			requires = { "nvim-gps" },
			config = function()
				require("plugins.wind_line")
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
		use({ "McAuleyPenney/tidy.nvim" })

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
			"machakann/vim-sandwich",
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
			-- config = function()
			-- 	require("indent_blankline").setup()
			-- 	require("plugins.indent-blankline")
			-- end,
		})
		-- highlights hex colors rgb(200, 200, 200)
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		})

		-- displays buffers at the top
		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("bufferline").setup({
					options = {
						show_buffer_icons = false,
						show_buffer_close_icons = false,
						show_close_icon = false,
					},
				})
			end,
		})

		use({
			"neovim/nvim-lspconfig",
			requires = { "williamboman/nvim-lsp-installer", "jose-elias-alvarez/nvim-lsp-ts-utils" },
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
				"lspkind-nvim",
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
		use({ "npxbr/glow.nvim", run = ":GlowInstall", ft = "markdown" })

		-- show pictograms on completion dropdown
		use({
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind").init({})
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
				require("legendary").setup({
					include_builtin = false,
					auto_register_which_key = true,
				})
				require("plugins.which_key")
			end,
		})

		-- hmm... `efm` might be more flexible?
		use({
			"jose-elias-alvarez/null-ls.nvim",
			after = { "nvim-lspconfig" },
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("plugins.null")
			end,
		})

		-- virtual text types (only in some languages)
		use({
			"jubnzv/virtual-types.nvim",
		})

		-- highlight word under cursor
		-- use({
		-- 	"RRethy/vim-illuminate",
		-- })
		use({
			"yamatsum/nvim-cursorline",
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

		-- use({ "roxma/vim-tmux-clipboard" })
		-- use({ "jabirali/vim-tmux-yank" })
		use({
			"ojroques/vim-oscyank",
			config = function()
				vim.cmd([[
          autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif
        ]])
			end,
		})

		use({ "stevearc/dressing.nvim" })

		use({
			"tanvirtin/vgit.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("vgit").setup()
			end,
		})

		use({
			"abecodes/tabout.nvim",
			config = function()
				require("tabout").setup()
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

		-- NOTE:  broken for now
		-- use({
		-- 	"simrat39/symbols-outline.nvim",
		-- })

		use({
			"dstein64/vim-startuptime",
		})

		use({
			"yioneko/nvim-yati",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"SmiteshP/nvim-gps",
			config = function()
				require("nvim-gps").setup()
			end,
		})

		use({
			"ethanholz/nvim-lastplace",
			config = function()
				require("nvim-lastplace").setup({})
			end,
		})

		use({
			"APZelos/blamer.nvim",
			config = function()
				vim.api.nvim_set_var("blamer_enabled", true)
				vim.api.nvim_set_var("blamer_show_in_insert_modes", false)
			end,
		})
	end,
})
