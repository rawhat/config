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
			["<leader>bp"] = {
				function()
					vim.cmd.echo({ "@%" })
				end,
				"Show relative path to buffer file",
			},
			["<leader>src"] = {
				function()
					vim.cmd.source({ "%" })
				end,
				"Source current file",
			},
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
				function()
					vim.cmd.bd({ bang = true })
				end,
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
				function()
					vim.cmd.wq()
				end,
				"Save and quit",
			},
			["<leader>wa"] = {
				function()
					vim.cmd.wqa()
				end,
				"Save and quit all",
			},
			["<leader>qq"] = {
				function()
					vim.cmd.qa()
				end,
				"Quit and close all",
			},
		}),

		generate({
			name = "quickfix",
			["<leader>q"] = {
				o = {
					function()
						vim.cmd.copen()
					end,
					"Open Quickfix",
				},
				c = {
					function()
						vim.cmd.cclose()
					end,
					"Close Quickfix",
				},
			},
		}, {
			noremap = false,
			silent = false,
		}),

		generate({
			["<leader>"] = {
				name = "lsp diagnostics",
				j = {
					function()
						vim.diagnostic.goto_next()
					end,
					"Next LSP Diagnostic",
				},
				k = {
					function()
						vim.diagnostic.goto_prev()
					end,
					"Prev LSP Diagnostic",
				},
				f = {
					function()
						vim.diagnostic.open_float()
					end,
					"Open LSP diagnostic float",
				},
			},
		}),

		generate({
			name = "lsp hover",
			F = {
				function()
					vim.lsp.buf.hover()
				end,
				"LSP Hover",
			},
		}),

		generate({
			name = "lsp restart",
			["<leader>ls"] = {
				function()
					vim.cmd.LspRestart()
				end,
				"Restart LSP server(s)",
			},
		}),

		generate({
			name = "trouble",
			xx = {
				function()
					vim.cmd.TroubleToggle()
				end,
				"Toggle Trouble",
			},
			gR = {
				function()
					vim.cmd.Trouble({ "lsp_references" })
				end,
				"Trouble LSP References",
			},
			gD = {
				function()
					vim.cmd.Trouble({ "lsp_definitions" })
				end,
				"Trouble LSP Definitions",
			},
			xw = {
				function()
					vim.cmd.Trouble({ "lsp_workspace_diagnostics" })
				end,
				"Trouble Workspace Diagnostics",
			},
			xd = {
				function()
					vim.cmd.Trouble({ "lsp_document_diagnostics" })
				end,
				"Trouble Doc Diagnostics",
			},
			xl = {
				function()
					vim.cmd.Trouble({ "loclist" })
				end,
				"Trouble Location List",
			},
			xq = {
				function()
					vim.cmd.Trouble({ "quickfix" })
				end,
				"Trouble Quickfix",
			},
		}, {
			prefix = "<leader>",
		}),

		generate({
			name = "nvim tree",
			["<C-n>"] = {
				function()
					vim.cmd.NvimTreeToggle()
				end,
				"Toggle nvim-tree",
			},
		}),

		generate({
			a = {
				name = "async run",
				r = {
					function()
						vim.cmd.AsyncRun()
					end,
					"Async Run",
				},
				w = {
					function()
						vim.cmd.AsyncRun({ "-raw" })
					end,
					"Async Run Raw",
				},
				s = {
					function()
						vim.cmd.AsyncStop()
					end,
					"Stop Async Task",
				},
			},
		}, {
			prefix = "<leader>",
		}),

		-- telescope
		generate({
			name = "telescope",
			["<C-p>"] = {
				function()
					require("telescope.builtin").find_files()
				end,
				"Find Files",
			},
			["<leader>ac"] = {
				function()
					require("telescope.builtin").commands()
				end,
				"Commands",
			},
			["<leader>ag"] = {
				function()
					require("telescope.builtin").live_grep()
				end,
				"Live Grep",
			},
			["<leader>bl"] = {
				function()
					require("telescope.builtin").buffers()
				end,
				"Buffers",
			},
			["<leader>ch"] = {
				function()
					require("telescope.builtin").command_history()
				end,
				"Command History",
			},
			["<leader>sc"] = {
				function()
					require("telescope.builtin").find_files({ search_dirs = { "~/.config/nvim" } })
				end,
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
				function()
					vim.cmd.Cheatsheet()
				end,
				"Keybind Cheat Sheet",
			},
			["<leader>sh"] = {
				function()
					require("telescope.builtin").search_history()
				end,
				"Search History",
			},
			["<leader>lr"] = {
				function()
					require("telescope.builtin").lsp_references()
				end,
				"LSP References",
			},
			["<leader>th"] = {
				function()
					require("telescope.builtin").help_tags()
				end,
				"Help Tags",
			},
			["<leader>of"] = {
				function()
					require("telescope.builtin").oldfiles()
				end,
				"Old Files",
			},
			["<leader>op"] = {
				function()
					require("telescope.builtin").vim_options()
				end,
				"ViM Options",
			},
			["<leader>sp"] = {
				function()
					require("telescope.builtin").spell_suggest()
				end,
				"Spelling suggestion",
			},
			["<leader>fb"] = {
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				"Fuzzy find in buffer",
			},
			["<leader>rp"] = {
				function()
					require("telescope.builtin").resume()
				end,
				"Resume Previous Picker",
			},
			["<leader>lp"] = {
				function()
					require("telescope.builtin").pickers()
				end,
				"List Previous Pickers",
			},
			["<leader>gd"] = {
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				"LSP Definition(s)",
			},
			["<leader>gi"] = {
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				"LSP Implementation(s)",
			},
			["<leader>gy"] = {
				function()
					require("telescope.builtin").lsp_type_definitions()
				end,
				"LSP Type Definition(s)",
			},
			["<leader>ld"] = {
				function()
					require("telescope.builtin").diagnostics()
				end,
				"LSP Diagnostics",
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
				function()
					require("telescope.builtin").grep_string()
				end,
				"Grep String",
			},
		}, {
			mode = "v",
		}),

		generate({
			name = "hop hint",
			["<leader>h"] = {
				function()
					require("hop").hint_words()
				end,
				"Show Hop Hints",
			},
		}),

		generate({
			name = "OSC yank",
			["<leader>y"] = {
				function()
					require("osc52").copy_visual()
				end,
				"Copy to OSC register",
			},
		}, { mode = "v" }),

		generate({
			name = "fugitive",
			["<leader>gb"] = {
				function()
					vim.cmd.Git({ "blame" })
				end,
				"Git blame for buffer",
			},
		}),

		generate({
			name = "VGit",
			["<leader>gd"] = {
				function()
					vim.cmd.VGit({ "buffer_diff_preview" })
				end,
				"Git diff for buffer",
			},
		}),

		generate({
			name = "Packer Commands",
			["<leader>p"] = {
				s = {
					function()
						vim.cmd.PackerSync()
					end,
					"Packer Sync",
				},
				c = {
					function()
						vim.cmd.PackerCompile()
					end,
					"Packer Compile",
				},
				i = {
					function()
						vim.cmd.PackerInstall()
					end,
					"Packer Install",
				},
			},
		}),

		generate({
			name = "Legendary",
			["<leader>wk"] = {
				function()
					require("legendary").find("keymaps")
				end,
				"Search keybinds, commands, autocmds",
			},
		}),

		generate({
			name = "Aerial",
			["<leader>ae"] = {
				function()
					vim.cmd.AerialToggle({ "right" })
				end,
				"Toggle the aerial view",
			},
		}),

		generate({
			name = "LSP Installer",
			["<leader>li"] = {
				function()
					vim.cmd.LspInstallInfo()
				end,
				"Open LSP Installer Modal",
			},
		}),
	}
end

return M
