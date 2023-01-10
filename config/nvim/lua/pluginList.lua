local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local theme = require("themes").current_theme

local plugins = {
	{
		theme.package,
		config = function()
			theme.config(theme.palette)
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		config = function()
			require("plenary.filetype").add_file("gleam")
		end,
	},
	{ "kchmck/vim-coffee-script", ft = "coffee" },
	{ "mtscout6/vim-cjsx", ft = "coffee" },
	---- crystal
	{ "rhysd/vim-crystal", ft = "crystal" },
	---- csv
	{ "chrisbra/csv.vim", ft = "csv" },
	---- deno
	{ "sigmaSd/deno-nvim" },
	---- fsharp
	{ "kongo2002/fsharp-vim", ft = "fsharp" },
	---- git
	"tpope/vim-git",
	---- jsonnet
	{
		"google/vim-jsonnet",
		ft = { "libsonnet", "jsonnet" },
		config = function()
			vim.cmd([[autocmd BufRead,BufNewFile *.libsonnet set filetype=jsonnet]])
		end,
	},
	-- just
	"NoahTheDuke/vim-just",
	{
		"IndianBoy42/tree-sitter-just",
		config = function()
			require("tree-sitter-just").setup({})
		end,
	},
	---- nginx
	{ "chr4/nginx.vim", ft = "nginx" },
	---- nim
	{ "zah/nim.vim", ft = "nim" },
	---- psql
	{ "lifepillar/pgsql.vim", ft = "sql" },
	---- proto
	{ "uarun/vim-protobuf", ft = "protobuf" },
	---- Pug
	{ "digitaltoad/vim-pug", ft = { "pug", "jade" } },
	---- purescript
	{ "purescript-contrib/purescript-vim", ft = "purescript" },
	---- reason
	{ "reasonml-editor/vim-reason-plus", ft = { "reason", "reasonreact" } },
	---- rust
	{
		"simrat39/rust-tools.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
				},
			})
		end,
	},
	---- sbt
	{ "derekwyatt/vim-sbt", ft = "sbt" },
	---- xml
	{ "amadeus/vim-xml", ft = "xml" },
	-- # general
	-- emmet
	{ "mattn/emmet-vim", ft = { "html", "typescriptreact", "javascriptreact" } },
	-- * for visual selections
	"nelstrom/vim-visual-star-search",
	-- :noh on cursor move
	"haya14busa/is.vim",
	-- run tests
	"janko/vim-test",
	-- shell commands
	"tpope/vim-eunuch",
	-- OTHER
	-- modified status bar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.lualine")
		end,
	},
	-- fuzzy find
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	"nvim-telescope/telescope-file-browser.nvim",
	-- search!
	"mileszs/ack.vim",
	-- removes trailing whitespace
	"mcauley-penney/tidy.nvim",
	-- ez commenting
	{
		"numToStr/Comment.nvim",
		config = function()
			local ft = require("Comment.ft")
			ft.set("gleam", "//%s")
			require("Comment").setup({
				mappings = false,
			})
		end,
	},
	-- git good
	"tpope/vim-fugitive",
	-- (--'happy times'--)
	{
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
	},
	-- highlight/jump to words
	{
		"phaazon/hop.nvim",
		config = function()
			require("plugins.hop")
		end,
	},
	-- fancy indent helper
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("plugins.indent-blankline")
		end,
	},
	-- highlights hex colors rgb(200, 200, 200)
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/nvim-lsp-ts-utils",
		},
		dependencies = { "mhartington/formatter.nvim", "williamboman/mason.nvim" },
		config = function()
			require("plugins.lspconfig")
		end,
	},
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("plugins.snip")
		end,
	},
	"rafamadriz/friendly-snippets",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("plugins.cmp")
		end,
	},
	{ "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
	{
		"scalameta/nvim-metals",
		config = function()
			require("plugins.metals")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { theme.package },
		config = function()
			require("trouble").setup()
		end,
	},
	-- file type icons
	{
		"yamatsum/nvim-nonicons",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	-- file tree
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		tag = "nightly",
		lazy = true,
		cmd = "NvimTreeToggle",
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
	},
	-- run things asynchronously
	"skywind3000/asyncrun.vim",
	-- neovim terminal manager
	{
		"akinsho/nvim-toggleterm.lua",
		dependencies = { theme.package },
		config = function()
			require("plugins.toggleterm")
		end,
	},
	-- tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	},
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-context",
	{
		"andymass/vim-matchup",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "windwp/nvim-autopairs" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	},
	-- markdown preview
	{
		"ellisonleao/glow.nvim",
		branch = "main",
		run = ":GlowInstall",
		ft = "markdown",
	},
	-- show pictograms on completion dropdown
	"onsails/lspkind.nvim",
	-- which key???
	{
		"folke/which-key.nvim",
		dependencies = { theme.package },
	},
	{
		"mrjones2014/legendary.nvim",
		dependencies = { "folke/which-key.nvim", "nvim-telescope/telescope.nvim" },
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
	},
	"mhartington/formatter.nvim",
	-- virtual text types (only in some languages)
	"jubnzv/virtual-types.nvim",
	{
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
	},
	-- a nicer quickfix window
	{
		"nvim-pqf",
		url = "https://gitlab.com/yorickpeterse/nvim-pqf.git",
		config = function()
			require("pqf").setup()
		end,
	},
	-- new pop-up???
	{
		"hood/popui.nvim",
		dependencies = { "RishabhRD/popfix" },
		config = function()
			vim.ui.select = require("popui.ui-overrider")
		end,
	},
	{
		"stevearc/dressing.nvim",
		config = function()
			require("dressing").setup({
				input = {
					min_width = { 120 },
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				keymaps = {},
			})
		end,
	},
	{
		"sudormrfbin/cheatsheet.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({
				layout = {
					min_width = 10,
				},
			})
		end,
	},
	"dstein64/vim-startuptime",
	{
		"yioneko/nvim-yati",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	"mrjones2014/smart-splits.nvim",
	{
		"mvllow/modes.nvim",
		dependencies = { theme.package },
		config = function()
			require("modes").setup({
				set_cursor = false,
				set_number = true,
			})
		end,
	},
	{
		"nvim-window",
		url = "https://gitlab.com/yorickpeterse/nvim-window.git",
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({})
		end,
	},
	{
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
	},
	"MunifTanjim/nui.nvim",
	{
		"anuvyklack/windows.nvim",
		dependencies = {
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
	},
	{
		"folke/noice.nvim",
		dependencies = {
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
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local langs = require("treesj.langs")
			local tsj_utils = require("treesj.langs.utils")

			langs["gleam"] = {
				list = tsj_utils.set_preset_for_list({
					join = {
						space_in_brackets = false,
					},
				}),
				tuple = tsj_utils.set_preset_for_list({
					both = {
						omit = { "#(" },
					},
					join = {
						space_in_brackets = false,
					},
				}),
				function_parameters = tsj_utils.set_preset_for_args({
					both = {
						last_separator = true,
					},
				}),
			}

			require("treesj").setup({
				use_default_keymaps = false,
				max_join_length = 80,
				langs = langs,
			})
		end,
	},
}

require("lazy").setup(plugins, {
	install = {
		-- is there a good way to abstract this?
		colorscheme = { "duskfox" },
	},
	diff = {
		cmd = "terminal_git",
	},
})
