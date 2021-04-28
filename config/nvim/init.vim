set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.elixir = {
--   install_info = {
--     url = "~/tree-sitter-elixir",
--     files = {"src/parser.c", "src/scanner.cc"},
--   },
--   filetype = "elixir",
--   used_by = {},
-- }

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}

require('lualine').setup {
  options = { theme = 'tokyonight' },
  extensions = { 'fzf', 'fugitive' },
  sections = {
    lualine_b = {
      { 'branch' },
      {'diagnostics', sources = {'coc'}},
    },
    lualine_c = {
      { 'filename', { full_path = true }},
    }
  },
}

require('surround').setup{}

require('nvim-ts-autotag').setup()

require('toggleterm').setup {
  size = 40,
  open_mapping = [[<leader>`]],
}

vim.api.nvim_exec([[
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
]], false)

vim.g.indent_blankline_show_first_indent_level = false

vim.api.nvim_set_keymap('n', '<leader>j', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<Plug>(coc-diagnostic-prev)', { silent = true })

vim.g["buftabline_numbers"] = 1
vim.g["buftabline_separators"] = 1
vim.api.nvim_set_keymap('n', '<leader>h', ':bprev<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':bnext<cr>', { silent = true })

vim.g["gitgutter_map_keys"] = 0

EOF
