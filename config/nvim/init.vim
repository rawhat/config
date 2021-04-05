set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.elixir = {
  install_info = {
    url = "/home/alex/tree-sitter-elixir",
    files = {"src/parser.c", "grammar.js"},
  },
  filetype = "elixir",
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}
EOF
