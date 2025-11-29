-- disable mouse
vim.opt.mouse = ""

-- don't display the mode; status bar handles that
vim.opt.showmode = false

-- offset top/bottom of scroll by 6 rows
vim.opt.scrolloff = 6

-- highlight searches
vim.opt.hlsearch = true
-- start searching while typing
vim.opt.incsearch = true
-- briefly jump to matching bracket/paren/etc when placed
vim.opt.showmatch = true

-- don't consider case when searching
vim.opt.ignorecase = true
-- match case when upper is provided
vim.opt.smartcase = true

-- Use auto indent
vim.o.autoindent = true
-- "smart" indent
vim.opt.smartindent = true
-- indent wrapped lines to match previous line
vim.opt.breakindent = true

-- Add padding for lists (if 'wrap' is set)
vim.o.breakindentopt = "list:-1"

-- Make popup menu smaller
vim.o.pumheight = 10
-- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.linebreak = true
-- Show helpful text indicators
-- vim.o.list = true
-- Improve comment editing
vim.o.formatoptions = "rqnl1j"
-- Treat camelCase word parts as separate words
vim.o.spelloptions = "camel"

-- extend lines past screen instead of wrapping
vim.opt.wrap = false

-- use file for undo history
vim.opt.undofile = true

-- prefer splitting windows right
vim.opt.splitright = true
-- prefer splitting windows below
vim.opt.splitbelow = true

-- hide concealed characters
vim.opt.conceallevel = 2

-- display menu even if only one entry
-- don't automatically select an entry, require actual selection
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- try these
vim.opt.jumpoptions = { "stack", "view" }
-- embed languages in vim strings
vim.g.vimsyn_embed = "alpPrj"
-- display small split for substitute-like command changes
vim.opt.inccommand = "split"
-- display this character when line wraps (probably not gonna happen
-- w/ wrap = false?)
vim.g.showbreak = "↪"

-- make tabs spaces again
vim.opt.expandtab = true
-- 4 spaces is too big
vim.opt.tabstop = 2
-- always 2
vim.opt.shiftwidth = 2
-- yep, should be 2
vim.opt.softtabstop = 2

-- not sure if this is needed with noice
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- can display 256 colors (maybe not needed)
vim.g.t_Co = "256"

-- display line numbers
vim.opt.number = true
-- display _relative_ line numbers
vim.opt.relativenumber = true

-- display different highlight for line cursor is on
vim.opt.cursorline = true

-- '0' is not bad
vim.o.foldcolumn = "1"
-- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.filetype.add({
	filename = {
		["Caddyfile"] = "caddy",
	},
})

-- for toggle term, reuse the same term
vim.opt.hidden = true

-- write to swap file after this many milliseconds of inaction
vim.opt.updatetime = 50
-- wait for key combinations for this many milliseconds
vim.opt.timeoutlen = 300

-- don't display when file is written
-- don't display search count (noice)
-- don't display messages for completion stuff? idk
vim.opt.shortmess:append("WcC")

-- always show column to left of numbers for lsp/git symbols
-- vim.wo.signcolumn = "auto:1-2"
vim.wo.signcolumn = "yes"

-- leader is space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- write file and overwrite old backup? i think
vim.g.backupcopy = "yes"

-- gimme the full gamut
vim.opt.termguicolors = true

-- allow cursor to go one char past the EOL
vim.opt.virtualedit = "onemore"

-- how dare you
vim.g.python_recommended_style = 0

-- Using `ripgrep` for searching
vim.g.ackprg = "rg --vimgrep --no-heading --smart-case"
vim.cmd([[cnoreabbrev rg Ack]])

-- show status line only once
vim.o.laststatus = 3
-- hide command line
vim.opt.cmdheight = 0

-- Treat dash as `word` textobject part
vim.o.iskeyword = "@,48-57,_,192-255,-"

-- Use already opened buffers when switching
vim.o.switchbuf = "usetab,uselast"

-- don't move cursor when splitting
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

-- try to avoid slowness of looking up clipboard
vim.opt.clipboard = "unnamedplus"

-- make 0 go to first word in line instead of start of line...
vim.api.nvim_exec2(
	[[
    noremap 0 ^
    noremap ^ 0
  ]],
	{ output = false }
)
