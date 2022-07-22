local M = {}

local wk = require("which-key")

function M.options()
	return {
		key_labels = { ["<leader>"] = ";" },
		plugins = {
			presets = {
				operators = false,
			},
		},
	}
end

local generate = function(key_table, key_opts)
	wk.register(key_table, key_opts or {})
end

-- register({
-- 	name = "split movement",
-- 	["<C-l>"] = { "<C-w><C-l>", "Move Right" },
-- 	["<C-k>"] = { "<C-w><C-k>", "Move Up" },
-- 	["<C-j>"] = { "<C-w><C-j>", "Move Down" },
-- 	["<C-h>"] = { "<C-w><C-h>", "Move Left" },
-- })

function M.mappings()
	local Terminal = require("toggleterm.terminal").Terminal
	local worker_term = Terminal:new({
		close_on_exit = false,
		cmd = vim.o.shell,
		direction = "vertical",
		count = 6,
		hidden = true,
	})
	local term_input
	return {
		-- resizing
		generate({
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
		}),

		-- like hop, but windows
		generate({
			name = "window",
			["<leader>m"] = {
				function()
					require("nvim-window").pick()
				end,
				"Jump to window",
			},
		}),

		generate({
			name = "Miscellaneous",
			["<leader>bp"] = { ":echo @%<cr>", "Show relative path to buffer file" },
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
					local Input = require("nui.input")
					term_input = Input({
						position = "50%",
						size = {
							width = "25%",
							height = "40%",
						},
						border = {
							style = "rounded",
							text = {
								top = "Enter a command",
								top_align = "center",
							},
						},
					}, {
						prompt = "> ",
						on_close = function()
							term_input:unmount()
						end,
						on_submit = function(value)
							if not value then
								term_input:unmount()
								return
							end

							if not worker_term:is_open() then
								worker_term:toggle(100)
							end
							worker_term:send(value)
							vim.cmd("stopinsert")
							term_input:unmount()
						end,
					})

					term_input:mount()
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
		}),

		generate({
			name = "quickfix",
			["<leader>q"] = {
				o = { ":copen<cr>", "Open Quickfix" },
				c = { ":cclose<cr>", "Close Quickfix" },
			},
		}, {
			noremap = false,
			silent = false,
		}),

		generate({
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
				f = {
					"<Cmd>lua vim.diagnostic.open_float()<cr>",
					"Open LSP diagnostic float",
				},
			},
		}),

		generate({
			name = "lsp hover",
			F = { "<Cmd>lua vim.lsp.buf.hover()<cr>", "LSP Hover" },
		}),

		generate({
			name = "lsp restart",
			["<leader>lr"] = {
				"<cmd>LspRestart<cr>",
				"Restart LSP server(s)",
			},
		}),

		-- generate({
		-- 	["<leader><space>f"] = {
		-- 		"<cmd>lua vim.lsp.buf.formatting()<cr>",
		-- 		"Format",
		-- 	},
		-- }),

		generate({
			g = {
				name = "lsp details",
				d = { "<Cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
				i = {
					"<Cmd>lua vim.lsp.buf.implementation()<cr>",
					"Go to Implementation",
				},
			},
		}),

		generate({
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
		}),

		generate({
			name = "nvim tree",
			["<C-n>"] = { "<Cmd>NvimTreeToggle<cr>", "Toggle nvim-tree" },
		}),
		-- register({
		-- 	name = "neo tree",
		-- 	["<C-n>"] = { "<Cmd>Neotree filesystem reveal left toggle<cr>", "Toggle neo-tree" },
		-- })

		generate({
			a = {
				name = "async run",
				r = { ":AsyncRun", "Async Run" },
				w = { ":AsyncRun -raw", "Async Run Raw" },
				s = { ":AsyncStop", "Stop Async Task" },
			},
		}, {
			prefix = "<leader>",
		}),

		-- fzf
		-- {
		--   name = "fzf",
		--   ["<C-p>"] = {
		--     "<cmd>lua require('fzf-lua').files()<cr>",
		--     "Find Files",
		--   },
		--   ["<leader>ag"] = {
		--     "<Cmd>lua require('fzf-lua').live_grep()<cr>",
		--     "Live Grep",
		--   },
		--   ["<leader>aw"] = {
		--     "<Cmd>lua require('fzf-lua').grep_cword()<cr>",
		--     "Live Grep",
		--   },
		-- },

		-- telescope
		generate({
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
		}),
		generate({
			["<leader>ca"] = {
				function()
					vim.lsp.buf.code_action()
				end,
				"Code Actions",
			},
		}, {
			mode = "n",
		}),
		generate({
			["<leader>ra"] = {
				function()
					local start = vim.api.nvim_buf_get_mark(0, "<")
					local ending = vim.api.nvim_buf_get_mark(0, ">")
					vim.lsp.buf.code_action(nil, start, ending)
				end,
				"Range Code Actions",
			},
		}, {
			mode = "v",
		}),
		generate({
			["<leader>ag"] = {
				"<Cmd>lua require('telescope.builtin').grep_string()<cr>",
				"Grep String",
			},
		}, {
			mode = "v",
		}),

		generate({
			name = "hop hint",
			["<leader>h"] = {
				"<cmd>lua require('hop').hint_words()<cr>",
				"Show Hop Hints",
			},
		}),

		generate({
			name = "OSC yank",
			["<leader>y"] = { ":OSCYank<cr>", "yank to term code thing" },
		}, { mode = "v" }),

		generate({
			name = "fugitive",
			["<leader>gb"] = { ":Git blame<cr>", "Git blame for buffer" },
		}),

		generate({
			name = "VGit",
			["<leader>gd"] = { ":VGit buffer_diff_preview<cr>", "Git diff for buffer" },
			["<leader>go"] = { ":VGit buffer_diff_preview ", "Git diff branch for buffer" },
		}),

		generate({
			name = "Packer Commands",
			["<leader>p"] = {
				s = {
					"<Cmd>PackerSync<cr>",
					"Packer Sync",
				},
				c = {
					"<Cmd>PackerCompile<cr>",
					"Packer Compile",
				},
				i = {
					"<Cmd>PackerInstall<cr>",
					"Packer Install",
				},
			},
		}),

		generate({
			name = "Legendary",
			["<leader>wk"] = {
				"<cmd>lua require('legendary').find('keymaps')<cr>",
				"Search keybinds, commands, autocmds",
			},
		}),

		generate({
			name = "Aerial",
			["<leader>ae"] = {
				"<Cmd>AerialToggle right<cr>",
				"Toggle the aerial view",
			},
		}),

		generate({
			name = "LSP Installer",
			["<leader>li"] = {
				":LspInstallInfo<cr>",
				"Open LSP Installer Modal",
			},
		}),
	}
end

return M
