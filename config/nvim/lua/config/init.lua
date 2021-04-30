local vim = vim

-- tree-sitter
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
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
  open_mapping = "<leader>`",
}

vim.api.nvim_exec([[
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
]], false)

vim.g["indent_blankline_show_first_indent_level"] = false

vim.g["buftabline_numbers"] = 1
vim.g["buftabline_separators"] = 1

vim.g["gitgutter_map_keys"] = 0

-- CoC settings
vim.g["coc_global_extensions"] = {
  'coc-tsserver',
  'coc-rust-analyzer',
  'coc-elixir',
  'coc-python',
  'coc-yaml',
  'coc-fsharp',
  'coc-prettier',
  'coc-lua'
}

vim.g["node_client_debug"] = 1

-- end CoC settings

vim.cmd[[filetype plugin indent on]]

-- Might be unnecessary post-treesitter
vim.g["jsx_ext_required"] = 1

-- Needed?
vim.cmd[[
  au BufRead,BufNewFile *.go set filetype=go
]]

-- Indent lines
vim.g["indent_guides_enable_on_vim_startup"] = 1
vim.g["indentLine_char_list"] = {'▏'}

-- Using `ripgrep` for searching
vim.g["ackprg"] = "rg --vimgrep --no-heading --smart-case"
vim.cmd[[cnoreabbrev rg Ack]]

vim.g["mix_format_on_save"] = 1

-- asyncrun
vim.g["asyncrun_open"] = 10
vim.g["asyncrun_local"] = 1

vim.cmd[[cnoreabbrev ar AsyncRun]]

-- fzf
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

-- Theme
vim.g["tokyonight_style"] = "night"
vim.cmd[[colorscheme tokyonight]]

-- less hard coc-nvim error color
vim.api.nvim_command[[
  autocmd ColorScheme * highlight CocErrorSign guifg=#bf616a
]]
