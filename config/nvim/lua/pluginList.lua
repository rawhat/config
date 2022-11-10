local present, _ = pcall(require, "packerInit")
local packer

if present then
	packer = require("packer")
else
	return false
end

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

	local theme = require("themes").current_theme
	local theme_package = theme.package
	local theme_package_name = theme.package_name

	-- COLORSCHEME
	use({
		theme_package,
		config = function()
			local theme = require("themes").current_theme
			theme.config(theme.palette)
		end,
		as = theme_package_name,
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
		requires = { "kyazdani42/nvim-web-devicons" },
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
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		after = { "dressing.nvim" },
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
				mappings = false,
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
					normal = "sa",
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
		"williamboman/mason.nvim",
		requires = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			"jose-elias-alvarez/nvim-lsp-ts-utils",
		},
		after = { "formatter.nvim", "mason.nvim" },
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

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
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
		after = { theme.package_name },
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
		tag = "nightly",
		config = function()
			local gheight = vim.api.nvim_list_uis()[1].height
			local gwidth = vim.api.nvim_list_uis()[1].width
			local width = 100
			local height = 30
			require("nvim-tree").setup({
				view = {
					float = {
						enable = true,
						open_win_config = {
							relative = "editor",
							width = width,
							height = height,
							row = (gheight - height) * 0.5,
							col = (gwidth - width) * 0.5,
						},
					},
				},
			})
		end,
	})

	-- run things asynchronously
	use({ "skywind3000/asyncrun.vim" })

	-- neovim terminal manager
	use({
		"akinsho/nvim-toggleterm.lua",
		after = { theme.package_name },
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
		"nvim-treesitter/nvim-treesitter-context",
	})

	use({
		"andymass/vim-matchup",
		after = "nvim-treesitter",
		config = function()
			vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
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
	})

	-- which key???
	use({
		"folke/which-key.nvim",
		after = { theme.package_name },
	})

	use({
		"mrjones2014/legendary.nvim",
		after = { "which-key.nvim", "telescope.nvim" },
		config = function()
			local wk_options = require("plugins.which_key").options()
			require("which-key").setup(wk_options)

			require("legendary").setup({
				which_key = {
					auto_register = true,
				},
			})
			require("plugins.which_key").mappings()
		end,
	})

	use({ "mhartington/formatter.nvim" })

	-- virtual text types (only in some languages)
	use({
		"jubnzv/virtual-types.nvim",
	})

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
		"ojroques/nvim-osc52",
		requires = { "which-key.nvim" },
		config = function()
			require("osc52").setup()

			local function copy(lines, _)
				require("osc52").copy(table.concat(lines, "\n"))
			end

			local function paste()
				return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
			end

			vim.g.clipboard = {
				name = "osc52",
				copy = { ["+"] = copy, ["*"] = copy },
				paste = { ["+"] = paste, ["*"] = paste },
			}
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
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				layout = {
					min_width = 10,
				},
			})
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
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	})

	use({
		"mrjones2014/smart-splits.nvim",
	})

	use({
		"mvllow/modes.nvim",
		after = { theme.package_name },
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
				hide = {
					cursorline = "focused_win",
				},
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
		"anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup({
				autowidth = {
					enable = false,
				},
				ignore = {
					buftype = { "quickfix" },
				},
				animation = {
					duration = 100,
					fps = 144,
					easing = "in_out_sine",
				},
			})
		end,
	})

	use({
		"AckslD/nvim-trevJ.lua",
		config = function()
			require("trevj").setup({
				containers = {
					gleam = {
						list = {
							final_separator = ",",
							final_end_line = true,
						},
						function_parameters = {
							final_separator = ",",
							final_end_line = true,
						},
						anonymous_function_parameters = {
							final_separator = ",",
							final_end_line = true,
						},
					},
				},
			})
		end,
	})

	use({
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"hrsh7th/nvim-cmp",
		},
		event = "VimEnter",
		config = function()
			require("noice").setup({
				lsp = {
					hover = {
						enabled = true,
					},
					signature = {
						enabled = true,
					},
					message = {
						enabled = true,
					},
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				presets = {
					lsp_doc_border = true,
				},
			})
		end,
	})
end)
