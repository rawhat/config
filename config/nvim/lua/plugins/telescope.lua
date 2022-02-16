local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function fzf_multi_select(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local num_selections = table.getn(picker:get_multi_selection())

	if num_selections > 1 then
		actions.send_selected_to_qflist(prompt_bufnr)
		actions.open_qflist(prompt_bufnr)
	else
		actions.file_edit(prompt_bufnr)
	end
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<cr>"] = fzf_multi_select,
				["<esc>"] = actions.close,
			},
			n = {
				["<cr>"] = fzf_multi_select,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")

--[[ vim.api.nvim_set_keymap('n', '<C-p>',
                        "<cmd>lua require('telescope.builtin').find_files()<cr>",
                        {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>ag',
                        "<cmd>lua require('telescope.builtin').live_grep()<cr>",
                        {noremap = true}) ]]
