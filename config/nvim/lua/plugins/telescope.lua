require('telescope').setup({})

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap(
  'n',
  '<C-p>',
  "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>ag',
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true }
)
