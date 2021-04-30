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
vim.api.nvim_set_keymap('n', '<leader>h', ':bprev<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':bnext<cr>', { silent = true })

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

-- from the lua guide
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
  return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

function _G.smart_shift_tab()
  return vim.fn.pumvisible() == 1 and t'<C-p>'
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', { expr = true, noremap = true })

vim.api.nvim_set_keymap('n', 'K', ":call CocAction('doHover')<cr>", { noremap = true, silent = true })

-- this doesn't do anything??
vim.api.nvim_set_keymap('i', '<C-space>', ':coc#refresh()<cr>', { silent = true, expr = true })

vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>co', '<Plug>(coc-list-outline)', { silent = true })

vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})

vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', {})
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', {})

vim.api.nvim_set_keymap('n', '<leader>j', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<Plug>(coc-diagnostic-prev)', { silent = true })

vim.g["node_client_debug"] = 1

vim.api.nvim_set_keymap('n', '<leader>co', ':copen<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>cc', ':cclose<cr>', {})

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

-- Binding `fzf` to ctrl-p
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<cr>', { noremap = true })

-- Using `ripgrep` for searching
vim.g["ackprg"] = "rg --vimgrep --no-heading --smart-case"
vim.cmd[[cnoreabbrev rg Ack]]

-- ???
vim.api.nvim_set_keymap('n', '<A-Down>', ':m .+1<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-Up>', ':m .-2<cr>', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-Down> <Esc>', ':m .+1<cr>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-Up> <Esc>', ':m .+1<cr>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<A-Down>', ":m '>+1<cr>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', '<A-Up>', ":m '<-2<cr>gv=gv", { noremap = true })

-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', {})

vim.g["mix_format_on_save"] = 1

-- asyncrun
vim.g["asyncrun_open"] = 10
vim.g["asyncrun_local"] = 1

vim.cmd[[cnoreabbrev ar AsyncRun]]

vim.api.nvim_set_keymap('n', '<leader>ar', ':AsyncRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>aw', ':AsyncRun -raw', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>as', ':AsyncStop', { silent = true })

-- kommentary
vim.api.nvim_set_keymap('v', '<leader>c<space>', '<Plug>kommentary_visual_default', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>c<space>', '<Plug>kommentary_line_default', { silent = true })

-- fzf
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'

-- Theme
vim.g["tokyonight_style"] = "night"
vim.cmd[[colorscheme tokyonight]]

-- less hard coc-nvim error color
vim.api.nvim_command[[
  autocmd ColorScheme * highlight CocErrorSign guifg=#bf616a
]]
