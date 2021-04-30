vim.api.nvim_set_keymap('n', '<leader>co', ':copen<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>cc', ':cclose<cr>', {})

vim.api.nvim_set_keymap('n', '<leader>h', ':bprev<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':bnext<cr>', { silent = true })

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

-- Binding `fzf` to ctrl-p
vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<cr>', { noremap = true })

-- ???
vim.api.nvim_set_keymap('n', '<A-Down>', ':m .+1<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<A-Up>', ':m .-2<cr>', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-Down> <Esc>', ':m .+1<cr>==gi', { noremap = true })
vim.api.nvim_set_keymap('i', '<A-Up> <Esc>', ':m .+1<cr>==gi', { noremap = true })
vim.api.nvim_set_keymap('v', '<A-Down>', ":m '>+1<cr>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', '<A-Up>', ":m '<-2<cr>gv=gv", { noremap = true })

-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', {})

vim.api.nvim_set_keymap('n', '<leader>ar', ':AsyncRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>aw', ':AsyncRun -raw', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>as', ':AsyncStop', { silent = true })

-- kommentary
vim.api.nvim_set_keymap('v', '<leader>c<space>', '<Plug>kommentary_visual_default', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>c<space>', '<Plug>kommentary_line_default', { silent = true })
