local M = {}

local options = vim.api.nvim_create_augroup("Options", { clear = true })

-- disable mouse
vim.cmd("set mouse=")

vim.opt.showmode = false

vim.opt.scrolloff = 6

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.wrap = false

vim.opt.undofile = true

-- split options
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.conceallevel = 2

vim.opt.completeopt = { "menuone", "noselect" }

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

vim.g.t_Co = "256"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

-- don't really use these, but treesitter parsing for folds
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "BUILD", "*.bzl", "WORKSPACE", "BUILD.bazel" },
	command = "setf bzl",
	group = options,
})

-- for toggle term, reuse the same term
vim.opt.hidden = true

vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

vim.opt.shortmess:append("WcC")

-- always show column to left of numbers for lsp/git symbols
-- vim.wo.signcolumn = "auto:1-2"
vim.wo.signcolumn = "yes"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.backupcopy = "yes"

vim.opt.termguicolors = true

-- allow cursor to go one char past the EOL
vim.opt.virtualedit = "onemore"

-- how dare you
vim.g.python_recommended_style = 0

-- Using `ripgrep` for searching
vim.g.ackprg = "rg --vimgrep --no-heading --smart-case"
vim.cmd([[cnoreabbrev rg Ack]])

vim.g.mix_format_on_save = 1

vim.g.node_client_debug = 1

vim.o.laststatus = 3
vim.opt.cmdheight = 0

if vim.fn.exists("&splitkeep") ~= 0 then
	vim.opt.splitkeep = "screen"
end

-- enable syntax highlighting in markdown blocks
vim.g.markdown_fenced_languages = {
	"bash",
	"bzl",
	"html",
	"java",
	"javascript",
	"javascriptreact",
	"python",
	"rust",
	"scala",
	"sh",
	"tsx=typescriptreact",
	"typescript",
	"typescriptreact",
}

vim.opt.clipboard = "unnamedplus"

-- make 0 go to first word in line instead of start of line...
vim.api.nvim_exec(
	[[
    noremap 0 ^
    noremap ^ 0
  ]],
	false
)

vim.g.ts_highlight_lua = true

return M
