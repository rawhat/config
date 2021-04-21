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
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    -- disable = { "tsx", "typescript" },
  },
}

require('lualine').setup {
  options = { theme = 'tokyonight' },
  extensions = { 'fzf', 'fugitive' },
  sections = {
    lualine_b = {
      {'diagnostics', sources = {'coc'}},
    },
  },
}

require('nvim-ts-autotag').setup()

require('toggleterm').setup {
  size = 40,
  open_mapping = [[<leader>`]],
}

vim.api.nvim_exec([[
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
]], false)

vim.g.indent_blankline_show_first_indent_level = false
EOF
