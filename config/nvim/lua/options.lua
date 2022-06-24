local M = {}

vim.opt.encoding = "utf-8"

vim.opt.scrolloff = 3

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

vim.g.t_Co = "256"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = "81"
vim.opt.cursorline = true

vim.cmd([[
  autocmd BufRead,BufNewFile *.bzl,WORKSPACE,BUILD.bazel setf bzl
  autocmd BufRead,BufNewFile BUILD setf bzl
]])

-- vim.opt.completeopt = { "menuone", "noselect" }

-- for toggle term, reuse the same term
vim.opt.hidden = true

-- These are set for CoC
vim.g.hidden = true
vim.g.nobackup = true
vim.g.nowritebackup = true

vim.opt.updatetime = 300

vim.opt.shortmess:append({ c = true })

-- always show column to left of numbers for lsp/git symbols
-- vim.wo.signcolumn = "auto:1-2"
vim.wo.signcolumn = "yes"

vim.g.mapleader = ";"

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

vim.opt.laststatus = 3
-- vim.opt.cmdheight = 0

-- significant impact here?  idk
local disabled_built_in_plugins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_in_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- enable syntax highlighting in markdown blocks
vim.g.markdown_fenced_languages = {
	"html",
	"python",
	"bash",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"java",
	"rust",
	"scala",
	-- "elixir",
	"bash=sh",
}

-- clipboard stuff
--[[ if vim.fn.executable("win32yank.exe") == 1 then
  print("got a win clipboard") ]]
--[[ vim.opt.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = { "win32yank.exe -i --crlf" },
			["*"] = { "win32yank.exe -i --crlf" },
		},
		paste = {
			["+"] = { "win32yank.exe -o --lf" },
			["*"] = { "win32yank.exe -o --lf" },
		},
		cache_enabled = 0,
	} ]]
-- end
-- vim.opt.clipboard = "unnamedplus"
vim.opt.clipboard:append("unnamedplus")

-- make 0 go to first word in line instead of start of line...
vim.api.nvim_exec(
	[[
    noremap 0 ^
    noremap ^ 0
  ]],
	false
)

return M
