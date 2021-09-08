local wk = require("which-key")

wk.setup({ key_labels = { ["<leader>"] = ";" } })

-- make 0 go to first word in line instead of start of line...
vim.api.nvim_exec(
	[[
  noremap 0 ^
  noremap ^ 0
]],
	false
)

wk.register({
	name = "split movement",
	["<C-l>"] = { "<C-w><C-l>", "Move Right" },
	["<C-k>"] = { "<C-w><C-k>", "Move Up" },
	["<C-j>"] = { "<C-w><C-j>", "Move Down" },
	["<C-h>"] = { "<C-w><C-h>", "Move Left" },
})

wk.register({
	name = "quickfix",
	["<leader>c"] = {
		o = { ":copen<cr>", "Open Quickfix" },
		c = { ":cclose<cr>", "Close Quickfix" },
	},
}, {
	noremap = false,
	silent = false,
})

wk.register({
	["<leader>"] = {
		name = "lsp diagnostics",
		j = { "<Cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next LSP Diagnostic" },
		k = { "<Cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev LSP Diagnostic" },
	},
})

wk.register({
	name = "lsp hover",
	K = { "<Cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover" },
})

wk.register({
	["<leader><space>f"] = {
		"<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>",
		"Format",
	},
})

wk.register({
	g = {
		name = "lsp details",
		d = { "<Cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
		i = { "<Cmd>lua vim.lsp.buf.implementation()<cr>", "Go to Implementation" },
	},
})

wk.register({
	name = "trouble",
	xx = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
	gR = { "<cmd>Trouble lsp_references<cr>", "Trouble LSP References" },
	gD = { "<cmd>Trouble lsp_definitions<cr>", "Trouble LSP Definitions" },
	xw = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Trouble Workspace Diagnostics" },
	xd = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Trouble Doc Diagnostics" },
	xl = { "<cmd>Trouble loclist<cr>", "Trouble Location List" },
	xq = { "<cmd>Trouble quickfix<cr>", "Trouble Quickfix" },
}, {
	prefix = "<leader>",
})

wk.register({
	name = "nerd tree",
	["<C-n>"] = { "<Cmd>NvimTreeToggle<cr>", "Toggle nvim-tree" },
})

wk.register({
	a = {
		name = "async run",
		r = { ":AsyncRun", "Async Run" },
		w = { ":AsyncRun -raw", "Async Run Raw" },
		s = { ":AsyncStop", "Stop Async Task" },
	},
}, {
	prefix = "<leader>",
})

wk.register({
	name = "kommentary visual",
	["c<space>"] = { "<Plug>kommentary_visual_default<cr>", "Toggle Selection Comment" },
}, {
	prefix = "<leader>",
	mode = "v",
})

wk.register({
	name = "kommentary normal",
	["c<space>"] = { "<Plug>kommentary_line_default<cr>", "Toggle Line Comment" },
}, {
	prefix = "<leader>",
})

wk.register({
	name = "telescope",
	["<C-p>"] = { "<Cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files" },
	["<leader>ag"] = { "<Cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
})

wk.register({
	name = "hop hint",
	["<leader>l"] = { "<cmd>lua require('hop').hint_words()<cr>", "Show Hop Hints" },
})