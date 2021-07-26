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

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- move between splits without ctrl+w
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-j>', '<C-w><C-j>')

map('n', '<leader>co', ':copen<cr>', {})
map('n', '<leader>cc', ':cclose<cr>', {})

map('n', '<leader>h', ':bprev<cr>')
map('n', '<leader>l', ':bnext<cr>')

map('i', '<Tab>', 'v:lua.smart_tab()', { expr = true })

map('n', 'K', "<Cmd>lua vim.lsp.buf.hover()<cr>")

-- lsp setup
map('n', '<leader>j', '<Cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
map('n', '<leader>k', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
map('n', '<leader><space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<cr>')
map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<cr>')

-- trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>gR', '<cmd>Trouble lsp_references<cr>')
map('n', '<leader>gD', '<cmd>Trouble lsp_definitions<cr>')
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")

-- ???
map('n', '<A-Down>', ':m .+1<cr>')
map('n', '<A-Up>', ':m .-2<cr>')
map('i', '<A-Down> <Esc>', ':m .+1<cr>==gi')
map('i', '<A-Up> <Esc>', ':m .+1<cr>==gi')
map('v', '<A-Down>', ":m '>+1<cr>gv=gv")
map('v', '<A-Up>', ":m '<-2<cr>gv=gv")

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<cr>', {})

map('n', '<leader>ar', ':AsyncRun')
map('n', '<leader>aw', ':AsyncRun -raw')
map('n', '<leader>as', ':AsyncStop')

-- kommentary
vim.api.nvim_set_keymap('v', '<leader>c<space>', '<Plug>kommentary_visual_default', {})
vim.api.nvim_set_keymap('n', '<leader>c<space>', '<Plug>kommentary_line_default', {})

-- compe
map('i', '<C-space>', 'compe#complete()', { expr = true })
map('i', '<CR>', 'compe#confirm("<CR>")', { expr = true })
map('i', '<C-e>', 'compe#close("<C-e>")', { expr = true })
