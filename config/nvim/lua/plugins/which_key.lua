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
					if vim.bo.buftype == "" then
						if vim.fn.exists(":LspStop") ~= 0 then
							vim.cmd("LspStop")
						end

						for name, _ in pairs(package.loaded) do
							if name:match("^user") then
								package.loaded[name] = nil
							end
						end

						dofile(vim.env.MYVIMRC)
						vim.cmd("PackerCompile")
						vim.notify("Wait for Compile Done", vim.log.levels.INFO)
					else
						vim.notify("Not available in this window/buffer", vim.log.levels.INFO)
					end
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
			name = "nvim-tree",
			["<C-i>"] = {
				function()
					vim.cmd.NvimTreeToggle()
				end,
				"Toggle nvim tree",
			},
		}),

		generate({
			name = "nvim-tree find file",
			["<C-n>"] = {
				function()
					if vim.api.nvim_buf_get_name(0) == "" then
						vim.cmd.NvimTreeToggle()
					else
						vim.cmd.NvimTreeFindFile()
					end
				end,
				"Open nvim tree at current file",
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
			["<leader>al"] = {
				function(opts)
					local conf = require("telescope.config").values
					print(vim.inspect(conf))
					local finders = require("telescope.finders")
					local make_entry = require("telescope.make_entry")
					local pickers = require("telescope.pickers")

					local flatten = vim.tbl_flatten

					opts = opts or {}
					opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
					opts.shortcuts = opts.shortcuts
						or {
							["l"] = "*.lua",
							["v"] = "*.vim",
							["n"] = "*.{vim,lua}",
							["c"] = "*.c",
						}
					opts.pattern = opts.pattern or "%s"

					local custom_grep = finders.new_async_job({
						command_generator = function(prompt)
							if not prompt or prompt == "" then
								return nil
							end

							local prompt_split = vim.split(prompt, "  ")

							local args = { "rg" }
							if prompt_split[1] then
								table.insert(args, "-e")
								table.insert(args, prompt_split[1])
							end

							if prompt_split[2] then
								table.insert(args, "-g")

								local pattern
								if opts.shortcuts[prompt_split[2]] then
									pattern = opts.shortcuts[prompt_split[2]]
								else
									pattern = prompt_split[2]
								end

								print("pattern is " .. string.format(opts.pattern, pattern))

								table.insert(args, string.format(opts.pattern, pattern))
							end

							return flatten({
								args,
								{
									"--color=never",
									"--no-heading",
									"--with-filename",
									"--line-number",
									"--column",
									"--smart-case",
								},
							})
						end,
						entry_maker = make_entry.gen_from_vimgrep(opts),
						cwd = opts.cwd,
					})

					pickers
						.new(opts, {
							debounce = 100,
							prompt_title = "Live Grep (with shortcuts)",
							finder = custom_grep,
							previewer = conf.grep_previewer(opts),
							sorter = require("telescope.sorters").empty(),
						})
						:find()
				end,
				"Multi Grep Test",
			},
			["<leader>ab"] = {
				function()
					vim.ui.input({ prompt = "Enter search term" }, function(search)
						if search == nil or search == "" then
							return
						end

						local finders = require("telescope.finders")
						local pickers = require("telescope.pickers")
						local conf = require("telescope.config").values
						local sorters = require("telescope.sorters")

						local entry_maker = function(entry)
							local _, _, filename, lnum, _ = string.find(entry, [[(..-):(%d+):(.*)]])
							return {
								value = entry,
								display = string.format("%s:%d", filename, lnum),
								ordinal = filename,
								filename = filename,
								lnum = tonumber(lnum),
							}
						end

						pickers
							.new({}, {
								prompt_title = "Finding (" .. search .. ")",
								finder = finders.new_job(function(args)
									local command = {}
									command = vim.list_extend(command, conf.vimgrep_arguments)
									command = vim.list_extend(command, { "-e", search })
									if args == "" or args == nil then
										return command
									end

									command = vim.list_extend(command, { "-g", args })
									return command
								end, entry_maker),
								previewer = conf.grep_previewer({}),
								sorter = sorters.highlighter_only({}),
							})
							:find()
					end)
				end,
				"grep string then filter found files by glob",
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
			["<leader>lo"] = {
				function()
					require("telescope.builtin").oldfiles()
				end,
				"Old Files",
			},
			["<leader>pt"] = {
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
			["<leader>bf"] = {
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
			["<leader>lf"] = {
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				"LSP Definition(s)",
			},
			["<leader>lm"] = {
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				"LSP Implementation(s)",
			},
			["<leader>lt"] = {
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
			["<leader>o"] = {
				function()
					require("hop").hint_words()
				end,
				"Show Hop Hints",
			},
		}),

		generate({
			name = "OSC yank",
			["<leader>y"] = {
				require("osc52").copy_visual,
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
			name = "Lazy Commands",
			["<leader>p"] = {
				s = {
					function()
						vim.cmd.Lazy("sync")
					end,
					"Lazy Sync",
				},
				i = {
					function()
						vim.cmd.Lazy()
					end,
					"Lazy Install",
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
			name = "Mason",
			["<leader>li"] = {
				function()
					vim.cmd.Mason()
				end,
				"Open Modal",
			},
		}),

		generate({
			name = "Commenting",
			["<leader>cc"] = {
				function()
					require("Comment.api").toggle.linewise.current()
				end,
				"Toggle comment on current line",
			},
		}),

		generate({
			name = "Commenting visual",
			["<leader>c"] = {
				function()
					-- Exit visual mode before running the comment toggle. This fixes a
					-- bug with my base usage here that did some weird stuff
					local key = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
					vim.api.nvim_feedkeys(key, "nx", false)
					require("Comment.api").toggle.linewise(vim.fn.visualmode())
				end,
				"Toggle comment on visual line",
			},
		}, { mode = "v" }),

		generate({
			name = "Windows",
			["<leader>z"] = {
				function()
					vim.cmd.WindowsMaximize()
				end,
				"Toggle maximize current window",
			},
		}),

		generate({
			name = "Noice",
			["<leader>n"] = {
				function()
					vim.cmd.Noice()
				end,
				"Open the `noice` menu",
			},
		}),

		generate({
			name = "treesj",
			J = {
				function()
					vim.cmd.TSJJoin()
				end,
				"Join lines together",
			},
			R = {
				function()
					vim.cmd.TSJSplit()
				end,
				"Split out joined lines",
			},
		}),
	}
end

return M
