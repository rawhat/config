return {
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
	keys = {
		{ "<C-p>", desc = "Find files", "<cmd>Telescope find_files<cr>" },
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
		{ "<leader>op", desc = "ViM Options", "<cmd>Telescope vim_options<cr>" },
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
					-- additional_args = { "-g" },
				})
			end,
		},
		{ "<leader>n", desc = "Open noice menu", "<cmd>Telescope noice initial_mode=normal<cr>" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<Esc>"] = actions.close,
						["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				path_display = {
					shorten = {
						len = 4,
						exclude = { -1 },
					},
				},
				preview = {
					treesitter = {
						disable = { "coffee" },
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("noice")
		telescope.load_extension("notify")
		telescope.load_extension("ui-select")
	end,
}
