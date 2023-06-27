local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
		lazy = false,
		priority = 1000,
		name = theme.name,
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
	-- shell commands
	"chrisgrieser/nvim-genghis",
	-- OTHER
	-- modified status bar
	{
		"rebelot/heirline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.heirline")
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
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"stevearc/dressing.nvim",
		},
		keys = {
			{ "<C-p>", desc = "Find files", "<cmd>Telescope find_files<cr>" },
			{ "<C-n>", desc = "Files in CWD", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>" },
			{ "<leader>ac", desc = "Find commands", "<cmd>Telescope commands<cr>" },
			{ "<leader>ag", desc = "Live Grep", "<cmd>Telescope live_grep<cr>" },
			{ "<leader>ag", mode = { "v" }, desc = "Grep string", "<cmd>Telescope grep_string<cr>" },
			{ "<leader>bl", desc = "Find buffers", "<cmd>Telescope buffers<cr>" },
			{ "<leader>ch", desc = "Command history", "<cmd>Telescope command_history<cr>" },
			{ "<leader>sh", desc = "Search history", "<cmd>Telescope search_history<cr>" },
			{ "<leader>lr", desc = "LSP references", "<cmd>Telescope lsp_references<cr>" },
			{ "<leader>lf", desc = "LSP definition(s)", "<cmd>Telescope lsp_definitions<cr>" },
			{ "<leader>lm", desc = "LSP implementations", "<cmd>Telescope lsp_implementations<cr>" },
			{ "<leader>lt", desc = "LSP type definition(s)", "<cmd>Telescope lsp_type_definitions<cr>" },
			{ "<leader>ld", desc = "LSP diagnostics", "<cmd>Telescope diagnostics<cr>" },
			{ "<leader>th", desc = "Help Tags", "<cmd>Telescope help_tags<cr>" },
			{ "<leader>pt", desc = "ViM Options", "<cmd>Telescope vim_options<cr>" },
			{ "<leader>sp", desc = "Spelling suggestions", "<cmd>Telescope spell_suggest<cr>" },
			{ "<leader>bf", desc = "Fuzzy find in buffer", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
			{ "<leader>rp", desc = "Resume previous picker", "<cmd>Telescope resume<cr>" },
			{ "<leader>lp", desc = "List previous pickers", "<cmd>Telescope pickers<cr>" },
			{ "<leader>gs", desc = "Find in git diff files", "<cmd>Telescope git_status<cr>" },
			{
				"<leader>sc",
				desc = "Find config files",
				function()
					require("telescope.builtin").find_files({
						search_dirs = { vim.fn.stdpath("config") },
					})
				end,
			},
			{
				"<leader>cf",
				desc = "Grep config files",
				function()
					require("telescope.builtin").live_grep({
						search_dirs = { vim.fn.stdpath("config") },
						additional_args = { "-g" },
					})
				end,
			},
		},
		config = function()
			require("plugins.telescope")
		end,
	},
	-- search!
	"mileszs/ack.vim",
	-- removes trailing whitespace
	"mcauley-penney/tidy.nvim",
	-- ez commenting
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		keys = {
			{
				"<leader>cc",
				desc = "Toggle comment on current line",
				function()
					require("Comment.api").toggle.linewise.current()
				end,
			},
			{
				"<leader>c",
				mode = { "v" },
				desc = "Toggle comment on visual lines",
				function()
					local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
					vim.api.nvim_feedkeys(key, "nx", false)
					require("Comment.api").toggle.blockwise(vim.fn.visualmode())
				end,
			},
		},
		config = function()
			local ft = require("Comment.ft")
			ft.set("gleam", "//%s")
			require("Comment").setup({
				mappings = false,
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	-- git good
	{
		"tpope/vim-fugitive",
		event = "BufRead",
		keys = {
			{ "<leader>gb", desc = "Git blame for buffer", "<cmd>Git blame<cr>" },
		},
	},
	-- (--'happy times'--)
	{
		"kylechui/nvim-surround",
		opts = {},
	},
	-- highlight/jump to words
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				desc = "jump around",
				function()
					require("flash").jump()
				end,
			},
			{
				"S",
				mode = { "o", "x" },
				desc = "leapin around the trees",
				function()
					require("flash").treesitter()
				end,
			},
		},
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
		keys = {
			{ "<leader>li", desc = "Open mason", "<cmd>Mason<cr>" },
		},
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason.nvim",
			"simrat39/rust-tools.nvim",
			"pmizio/typescript-tools.nvim",
		},
		config = function()
			require("plugins.lspconfig")
		end,
	},
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
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
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
	{
		"scalameta/nvim-metals",
		config = function()
			require("plugins.metals")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { theme.package },
		keys = {
			{ "<leader>xx", desc = "Toggle Trouble", "<cmd>TroubleToggle<cr>" },
		},
		config = function()
			require("trouble").setup()
		end,
	},
	-- file type icons
	{
		"yamatsum/nvim-nonicons",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		run = ":TSUpdate all",
		config = function()
			require("plugins.treesitter")
		end,
	},
	{
		"andymass/vim-matchup",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			vim.api.nvim_set_var("matchup_matchparen_offscreen", { method = "popup" })
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
		opts = {
			key_labels = { ["<leader>"] = "<space>" },
			plugins = {
				presets = {
					operators = false,
				},
			},
		},
	},
	{
		"mrjones2014/legendary.nvim",
		dependencies = { "folke/which-key.nvim", "nvim-telescope/telescope.nvim" },
		priority = 10000,
		lazy = false,
		keys = {
			{ "<leader>wk", desc = "Search keybinds, commands, autocommands", "<cmd>Legendary keymaps<cr>" },
		},
		config = function()
			require("legendary").setup({
				lazy_nvim = {
					auto_register = true,
				},
				which_key = {
					auto_register = true,
				},
			})
		end,
	},
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
		"kevinhwang91/nvim-bqf",
		ft = "qf",
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
				trouble = true,
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
		keys = {
			{ "<leader>cs", desc = "Keybind cheat sheet", "<cmd>Cheatsheet<cr>" },
		},
		config = function()
			require("cheatsheet").setup({
				["<CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
				["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		keys = {
			{ "<leader>so", desc = "Toggle the symbol outline view", "<cmd>SymbolsOutline<cr>" },
		},
		config = function()
			require("symbols-outline").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		keys = {
			{
				"<C-l>",
				desc = "Resize right",
				function()
					require("smart-splits").resize_right()
				end,
			},
			{
				"<C-k>",
				desc = "Resize up",
				function()
					require("smart-splits").resize_up()
				end,
			},
			{
				"<C-j>",
				desc = "Resize down",
				function()
					require("smart-splits").resize_down()
				end,
			},
			{
				"<C-h>",
				desc = "Resize left",
				function()
					require("smart-splits").resize_left()
				end,
			},
		},
	},
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
		"yorickpeterse/nvim-window",
		url = "https://gitlab.com/yorickpeterse/nvim-window.git",
		keys = {
			{
				"<leader>m",
				desc = "Jump to window",
				function()
					require("nvim-window").pick()
				end,
			},
		},
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
		keys = {
			{ "<leader>xz", desc = "Toggle maximize current buffer", "<cmd>WindowsMaximize<cr>" },
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
		enabled = function()
			return vim.fn.exists("g:fvim_loaded") == 0
		end,
		event = "VimEnter",
		keys = {
			{ "<leader>n", desc = "Open the noice menu", "<cmd>Noice<cr>" },
			{ "<leader>ds", desc = "Dismiss noice notifications", "<;md>Noice dismiss<cr>" },
		},
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
		"ojroques/nvim-osc52",
		keys = {
			{
				"<leader>y",
				mode = { "v" },
				desc = "Copy text via OSC52",
				function()
					require("osc52").copy_visual()
				end,
			},
		},
		config = function()
			require("osc52").setup()
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			local group = vim.api.nvim_create_augroup("Lightbulb", {
				clear = false,
			})
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				callback = require("nvim-lightbulb").update_lightbulb,
				group = group,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>do", desc = "Open diffview against develop", "<cmd>DiffviewOpen origin/develop<cr>" },
			{ "<leader>dv", desc = "Open diffview against HEAD", "<cmd>DiffviewOpen<cr>" },
			{
				"<leader>db",
				desc = "Open diffview against branch",
				function()
					vim.ui.input({ prompt = "Branch to diff against" }, function(search)
						vim.cmd.DiffviewOpen(search)
					end)
				end,
			},
			{ "<leader>dc", desc = "Close diffview", "<cmd>DiffviewClose<cr>" },
			{ "<leader>df", desc = "Toggle diffview file panel", "<cmd>DiffviewToggleFiles<cr>" },
		},
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			disabled_filetypes = {
				"lazy",
				"mason",
				"nvim-tree",
				"quickfix",
			},
		},
	},
	{
		"rebelot/terminal.nvim",
		keys = {
			{
				"<leader>tr",
				desc = "<r>run command in split term",
				function()
					require("terminal").run(nil, {
						layout = { open_cmd = "botright vertical new" },
					})
				end,
			},
		},
		config = function()
			require("terminal").setup({
				layout = {
					open_cmd = "float",
					width = 0.75,
					height = 0.75,
				},
			})
			vim.api.nvim_create_autocmd("TermOpen", {
				callback = function()
					vim.cmd([[
			         setlocal nonumber norelativenumber nocursorline winhl=Normal:NormalFloat
			         tnoremap <buffer> <Esc> <c-\><c-n>
			       ]])
				end,
			})
			vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
				callback = function(args)
					if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
						vim.cmd("startinsert")
					end
				end,
			})
		end,
	},
	{
		"willothy/moveline.nvim",
		build = "make",
		keys = {
			{
				"<C-k>",
				mode = { "v" },
				desc = "Move selection up",
				function()
					require("moveline").block_up()
				end,
			},
			{
				"<C-j>",
				mode = { "v" },
				desc = "Move selection down",
				function()
					require("moveline").block_down()
				end,
			},
		},
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				bt_ignore = { "terminal", "nofile" },
				relculright = true,
				segments = {
					{ sign = { name = { "Diagnostic" } }, maxwidth = 2, auto = true },
					{ text = { builtin.lnumfunc } },
					{ sign = { name = { "GitSigns" } }, maxwidth = 1, colwidth = 1, auto = true },
				},
			})
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		cond = function()
			return vim.fn.has("linux") == 1 or vim.fn.has("macunix") == 1
		end,
		config = function()
			local colors = require("catppuccin.palettes").get_palette("mocha")
			vim.g.tpipeline_clearstl = 1
			-- Unfortunately, these need to be different or else vim throws in `^^^` :(
			vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.base, fg = colors.surface0 })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.base, fg = colors.mantle })
			vim.cmd("set fcs=stlnc:─,stl:─,vert:│")
		end,
	},
}

require("lazy").setup(plugins, {
	install = {
		colorscheme = { theme.current_theme },
	},
	diff = {
		cmd = "terminal_git",
	},
})
