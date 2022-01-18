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
	name = "Miscellaneous",
	["<leader>fp"] = { ":echo @%<cr>", "Show relative path to buffer file" },
	["<leader>src"] = { ":source %<cr>", "Source current file" },
})

wk.register({
	name = "quickfix",
	["<leader>q"] = {
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
		j = {
			"<Cmd>lua vim.diagnostic.goto_next()<cr>",
			"Next LSP Diagnostic",
		},
		k = {
			"<Cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev LSP Diagnostic",
		},
	},
})

wk.register({
	name = "lsp hover",
	K = { "<Cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover" },
})

wk.register({
	["<leader><space>f"] = {
		"<cmd>lua vim.lsp.buf.formatting()<cr>",
		"Format",
	},
})

wk.register({
	g = {
		name = "lsp details",
		d = { "<Cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
		i = {
			"<Cmd>lua vim.lsp.buf.implementation()<cr>",
			"Go to Implementation",
		},
	},
})

wk.register({
	name = "trouble",
	xx = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
	gR = { "<cmd>Trouble lsp_references<cr>", "Trouble LSP References" },
	gD = { "<cmd>Trouble lsp_definitions<cr>", "Trouble LSP Definitions" },
	xw = {
		"<cmd>Trouble lsp_workspace_diagnostics<cr>",
		"Trouble Workspace Diagnostics",
	},
	xd = {
		"<cmd>Trouble lsp_document_diagnostics<cr>",
		"Trouble Doc Diagnostics",
	},
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

local fzf = {
	name = "fzf",
	["<C-p>"] = {
		"<cmd>lua require('fzf-lua').files()<cr>",
		"Find Files",
	},
	["<leader>ag"] = {
		"<Cmd>lua require('fzf-lua').live_grep()<cr>",
		"Live Grep",
	},
	["<leader>aw"] = {
		"<Cmd>lua require('fzf-lua').grep_cword()<cr>",
		"Live Grep",
	},
}

local telescope = {
	name = "telescope",
	["<C-p>"] = {
		"<Cmd>lua require('telescope.builtin').find_files()<cr>",
		"Find Files",
	},
	["<leader>ac"] = {
		"<Cmd>lua require('telescope.builtin').commands()<cr>",
		"Commands",
	},
	["<leader>ag"] = {
		"<Cmd>lua require('telescope.builtin').live_grep()<cr>",
		"Live Grep",
	},
	["<leader>b"] = {
		"<Cmd>lua require('telescope.builtin').buffers()<cr>",
		"Buffers",
	},
	["<leader>ca"] = {
		"<Cmd>lua require('telescope.builtin').lsp_code_actions()<cr>",
		"Code Actions",
	},
	["<leader>ch"] = {
		"<Cmd>lua require('telescope.builtin').command_history()<cr>",
		"Command History",
	},
	["<leader>sc"] = {
		"<Cmd>lua require('telescope.builtin').find_files({ search_dirs = {'~/.config/nvim'} })<cr>",
		"Find Config Files",
	},
	["<leader>cf"] = {
		function()
			local search_dirs = { "~/.config/nvim" }
			-- TODO:  is it okay to ignore opts here?  it... doesn't seem to like
			-- either a table OR a string
			local additional_args = function(opts)
				return { "-g", "!packer_compiled.lua" }
			end

			require("telescope.builtin").live_grep({
				search_dirs = search_dirs,
				additional_args = additional_args,
			})
		end,
		"Grep Config Files",
	},
	["<leader>cs"] = {
		"<Cmd>Cheatsheet<cr>",
		"Keybind Cheat Sheet",
	},
	["<leader>sh"] = {
		"<Cmd>lua require('telescope.builtin').search_history()<cr>",
		"Search History",
	},
	["<leader>sr"] = {
		"<Cmd>lua require('telescope.builtin').lsp_references()<cr>",
		"LSP References",
	},
	["<leader>t"] = {
		"<Cmd>lua require('telescope.builtin').help_tags()<cr>",
		"Help Tags",
	},
}

wk.register(telescope)
wk.register({
	["<leader>ag"] = {
		"<Cmd>lua require('telescope.builtin').grep_string()<cr>",
		"Grep String",
	},
}, {
	mode = "v",
})

wk.register({
	name = "hop hint",
	["<leader>h"] = {
		"<cmd>lua require('hop').hint_words()<cr>",
		"Show Hop Hints",
	},
})

wk.register({
	name = "OSC yank",
	["<leader>y"] = { ":OSCYank<cr>", "yank to term code thing" },
}, { mode = "v" })

wk.register({
	name = "fugitive",
	["<leader>gb"] = { ":Git blame<cr>", "Git blame for buffer" },
})

wk.register({
	name = "VGit",
	["<leader>gd"] = { ":VGit buffer_diff_preview<cr>", "Git diff for buffer" },
	["<leader>go"] = { ":VGit buffer_diff_preview ", "Git diff branch for buffer" },
})

wk.register({
	name = "Packer Sync",
	["<leader>ps"] = {
		"<Cmd>PackerSync<cr>",
		"Packer Sync",
	},
})
