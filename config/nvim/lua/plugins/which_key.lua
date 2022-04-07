local wk = require("which-key")

wk.setup({
	key_labels = { ["<leader>"] = ";" },
	plugins = {
		presets = {
			operators = false,
		},
	},
})

-- make 0 go to first word in line instead of start of line...
vim.api.nvim_exec(
	[[
  noremap 0 ^
  noremap ^ 0
]],
	false
)

local register = function(key_table, key_opts)
	wk.register(key_table, key_opts or {})
end

-- register({
-- 	name = "split movement",
-- 	["<C-l>"] = { "<C-w><C-l>", "Move Right" },
-- 	["<C-k>"] = { "<C-w><C-k>", "Move Up" },
-- 	["<C-j>"] = { "<C-w><C-j>", "Move Down" },
-- 	["<C-h>"] = { "<C-w><C-h>", "Move Left" },
-- })

-- resizing
register({
	name = "splitzzz",
	["<S-l>"] = {
		function()
			require("smart-splits").resize_right()
		end,
		"Resize Right",
	},
	["<S-k>"] = {
		function()
			require("smart-splits").resize_up()
		end,
		"Resize Up",
	},
	["<S-j>"] = {
		function()
			require("smart-splits").resize_down()
		end,
		"Resize Down",
	},
	["<S-h>"] = {
		function()
			require("smart-splits").resize_left()
		end,
		"Resize Left",
	},
})

-- like hop, but windows
register({
	name = "window",
	["<leader>m"] = {
		function()
			require("nvim-window").pick()
		end,
		"Jump to window",
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local worker_term = Terminal:new({
	close_on_exit = false,
	cmd = vim.o.shell,
	direction = "vertical",
	count = 6,
	hidden = true,
})

register({
	name = "Miscellaneous",
	["<leader>fp"] = { ":echo @%<cr>", "Show relative path to buffer file" },
	["<leader>src"] = { ":source %<cr>", "Source current file" },
	["<leader>gt"] = {
		function()
			local row = vim.api.nvim_win_get_cursor(0)[1]
			local file = vim.api.nvim_buf_get_name(0)
			local relative_path = string.gsub(file, vim.loop.cwd(), "")

			local url = vim.fn.system("gitiles " .. relative_path)
			print(string.gsub(url, "\n", "") .. "#" .. row)
		end,
		"Gitiles link to current line",
	},
	["<leader>bd"] = {
		":bd!",
		"Delete buffer (press enter)",
	},
	["<leader>tr"] = {
		function()
			vim.ui.input({
				prompt = "Enter command to run:  ",
			}, function(input)
				if not input then
					return
				end

				if not worker_term:is_open() then
					worker_term:toggle(100)
				end
				worker_term:send(input)
				vim.cmd("stopinsert")
			end)
		end,
		"<r>un <c>command and toss the output into a vsplit",
	},
	["<leader>tc"] = {
		function()
			worker_term:send("clear")
			vim.cmd("stopinsert")
		end,
		"<t>erminal <c>lear on the worker",
	},
	["<leader>wq"] = {
		"<Cmd>wq<cr>",
		"Save and quit",
	},
	["<leader>wa"] = {
		"<Cmd>wqa<cr>",
		"Save and quit all",
	},
	["<leader>qq"] = {
		"<Cmd>qa<cr>",
		"Quit and close all",
	},
})

register({
	name = "quickfix",
	["<leader>q"] = {
		o = { ":copen<cr>", "Open Quickfix" },
		c = { ":cclose<cr>", "Close Quickfix" },
	},
}, {
	noremap = false,
	silent = false,
})

register({
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

register({
	name = "lsp hover",
	F = { "<Cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover" },
})

register({
	["<leader><space>f"] = {
		"<cmd>lua vim.lsp.buf.formatting()<cr>",
		"Format",
	},
})

register({
	g = {
		name = "lsp details",
		d = { "<Cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
		i = {
			"<Cmd>lua vim.lsp.buf.implementation()<cr>",
			"Go to Implementation",
		},
	},
})

register({
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

register({
	name = "nvim tree",
	["<C-n>"] = { "<Cmd>NvimTreeToggle<cr>", "Toggle nvim-tree" },
})
-- register({
-- 	name = "neo tree",
-- 	["<C-n>"] = { "<Cmd>Neotree filesystem reveal left toggle<cr>", "Toggle neo-tree" },
-- })

register({
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
	["<leader>bl"] = {
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
	["<leader>th"] = {
		"<Cmd>lua require('telescope.builtin').help_tags()<cr>",
		"Help Tags",
	},
}

register(telescope)
register({
	["<leader>ag"] = {
		"<Cmd>lua require('telescope.builtin').grep_string()<cr>",
		"Grep String",
	},
}, {
	mode = "v",
})

register({
	name = "hop hint",
	["<leader>h"] = {
		"<cmd>lua require('hop').hint_words()<cr>",
		"Show Hop Hints",
	},
})

register({
	name = "OSC yank",
	["<leader>y"] = { ":OSCYank<cr>", "yank to term code thing" },
}, { mode = "v" })

register({
	name = "fugitive",
	["<leader>gb"] = { ":Git blame<cr>", "Git blame for buffer" },
})

register({
	name = "VGit",
	["<leader>gd"] = { ":VGit buffer_diff_preview<cr>", "Git diff for buffer" },
	["<leader>go"] = { ":VGit buffer_diff_preview ", "Git diff branch for buffer" },
})

register({
	name = "Packer Sync",
	["<leader>ps"] = {
		"<Cmd>PackerSync<cr>",
		"Packer Sync",
	},
})

register({
	name = "Legendary",
	["<leader>wk"] = {
		"<cmd>lua require('legendary').find()<cr>",
		"Search keybinds, commands, autocmds",
	},
})

register({
	name = "Symbols Outline",
	["<leader>so"] = {
		":SymbolsOutline<cr>",
		"Toggle Symbols View",
	},
})

register({
	name = "LSP Installer",
	["<leader>li"] = {
		":LspInstallInfo<cr>",
		"Open LSP Installer Modal",
	},
})
