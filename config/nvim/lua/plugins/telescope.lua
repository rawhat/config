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
		{ "<leader>gd", desc = "Find in git diff files", "<cmd>Telescope git_status<cr>" },
		{ "<leader>gl", desc = "Find in jumplist", "<cmd>Telescope jumplist<cr>" },
		{ "<leader>lp", desc = "List previous pickers", "<cmd>Telescope pickers<cr>" },
		{ "<leader>rp", desc = "Resume previous picker", "<cmd>Telescope resume<cr>" },
		{ "<leader>sb", desc = "Fuzzy find in buffer", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
		{ "<leader>sc", desc = "Search commands", "<cmd>Telescope commands<cr>" },
		{ "<leader>sd", desc = "Search LSP diagnostics", "<cmd>Telescope diagnostics<cr>" },
		{ "<leader>sf", desc = "Search files", "<cmd>Telescope find_files<cr>" },
		{ "<leader>sh", desc = "Search help Tags", "<cmd>Telescope help_tags<cr>" },
		{ "<leader>si", desc = "Search... search history", "<cmd>Telescope search_history<cr>" },
		{ "<leader>sl", desc = "Search buffers", "<cmd>Telescope buffers<cr>" },
		{ "<leader>sm", desc = "Search command history", "<cmd>Telescope command_history<cr>" },
		{ "<leader>sp", desc = "Search ViM Options", "<cmd>Telescope vim_options<cr>" },
		{ "<leader>sw", desc = "Search word", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>sw", mode = { "v" }, desc = "Search highlighted word", "<cmd>Telescope grep_string<cr>" },
		{
			"<leader>sg",
			desc = "Find config files",
			function()
				require("telescope.builtin").find_files({
					search_dirs = { vim.fn.stdpath("config") },
				})
			end,
		},
		{
			"<leader>so",
			desc = "Grep config files",
			function()
				require("telescope.builtin").live_grep({
					search_dirs = { vim.fn.stdpath("config") },
					-- additional_args = { "-g" },
				})
			end,
		},
		{ "<leader>sn", desc = "Search noice", "<cmd>Telescope noice initial_mode=normal<cr>" },
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
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("noice")
		telescope.load_extension("notify")
		telescope.load_extension("ui-select")
	end,
}
