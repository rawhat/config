-- move between splits without ctrl+w
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })

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

vim.api.nvim_set_keymap('n', 'K', "<Cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })

-- lsp setup
vim.api.nvim_set_keymap('n', '<leader>j', '<Cmd>lua vim.lsp.diagnostic.goto_next()<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader><space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<cr>', { silent = true, noremap = true })

-- trouble
vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gR', '<cmd>Trouble lsp_references<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gD', '<cmd>Trouble lsp_definitions<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })

-- Binding `fzf` to ctrl-p
-- vim.api.nvim_set_keymap('n', '<C-p>', ':FZF<cr>', { noremap = true })

-- telescope
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ag', '<cmd>Telescope live_grep<cr>', { noremap = true })
-- probably won't use these very much, if ever...
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })

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

-- compe
vim.api.nvim_set_keymap('i', '<C-space>', 'compe#complete()', { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("<CR>")', { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', { expr = true, silent = true, noremap = true })
