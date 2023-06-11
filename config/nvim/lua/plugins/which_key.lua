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
	local toggle_term = require("terminal").terminal:new({})
	return {
		-- resizing
		generate({
			name = "splitzzz",
			["<C-l>"] = {
				function()
					require("smart-splits").resize_right()
				end,
				"Resize Right",
			},
			["<C-k>"] = {
				function()
					require("smart-splits").resize_up()
				end,
				"Resize Up",
			},
			["<C-j>"] = {
				function()
					require("smart-splits").resize_down()
				end,
				"Resize Down",
			},
			["<C-h>"] = {
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
			["<leader>gt"] = {
				function()
					local cwd = vim.loop.cwd()
					if cwd == "/home/alex/vistar/vistar" then
						local row = vim.api.nvim_win_get_cursor(0)[1]
						local file = vim.api.nvim_buf_get_name(0)
						local relative_path = string.gsub(file, vim.loop.cwd(), "")

						local gitiles_url = "https://gerrit.vistarmedia.com/plugins/gitiles/vistar/+/refs/heads/develop"

						local with_row = gitiles_url .. relative_path .. "#" .. row

						require("osc52").copy(with_row)
						require("notify")("Gitiles URL copied to clipboard\n\n" .. with_row, "info")
					else
						require("notify")("Can only be called from vistar root", "error")
					end
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
					require("terminal").run(nil, {
						layout = { open_cmd = "botright vertical new" },
					})
				end,
				"<r>un command and toss the output into a vsplit",
			},
			["<leader>tc"] = {
				function()
					toggle_term:send("clear")
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
			["<leader>is"] = {
				function()
					vim.cmd.Inspect()
				end,
				"display highlight information",
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
			["<C-n>"] = {
				function()
					local cwd = vim.fn.expand("%:h")
					cwd = string.gsub(cwd, vim.loop.cwd(), "")
					local cmd = "fd -t f -d 1 . " .. cwd

					local picker = require("telescope.pickers")
					local finders = require("telescope.finders")
					local utils = require("telescope.utils")

					picker
						.new({}, {
							prompt_title = cwd,
							previewer = require("telescope.previewers").vim_buffer_cat.new({}),
							finder = finders.new_table({
								results = utils.get_os_command_output({
									vim.o.shell,
									"-c",
									cmd,
								}),
							}),
							sorter = require("telescope.sorters").get_fuzzy_file(),
						})
						:find()
				end,
				"Files in CWD",
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
					require("telescope.builtin").find_files({
						search_dirs = { vim.fn.stdpath("config") },
					})
				end,
				"Find Config Files",
			},
			["<leader>cf"] = {
				function()
					local search_dirs = { "~/.config/nvim" }
					-- TODO:  is it okay to ignore opts here?  it... doesn't seem to like
					-- either a table OR a string
					local additional_args = function()
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
			["<leader>gf"] = {
				function() end,
				"List file diff of HEAD~1",
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
			name = "fugitive",
			["<leader>gb"] = {
				function()
					vim.cmd.Git({ "blame" })
				end,
				"Git blame for buffer",
			},
		}),

		generate({
			name = "Lazy Commands",
			["<leader>z"] = {
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
				o = {
					function()
						vim.cmd.Lazy("home")
					end,
					"Lazy Home",
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
			name = "Symbols outline",
			["<leader>so"] = {
				function()
					vim.cmd.SymbolsOutline()
				end,
				"Toggle the symbol outline view",
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
					require("Comment.api").toggle.blockwise(vim.fn.visualmode())
				end,
				"Toggle comment on visual line",
			},
		}, { mode = "v" }),

		generate({
			name = "Windows",
			["<leader>xz"] = {
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
			["<leader>ds"] = {
				function()
					vim.cmd.Noice("dismiss")
				end,
				"Dismiss all noice notifications",
			},
		}),

		generate({
			name = "osc52",
			["<leader>y"] = {
				require("osc52").copy_visual,
				"copy text via OSC52",
			},
		}, { mode = "v" }),

		generate({
			name = "DiffView",
			["<leader>do"] = {
				function()
					vim.cmd.DiffviewOpen("origin/develop")
				end,
				"Open DiffView against develop",
			},
			["<leader>dv"] = {
				function()
					vim.cmd.DiffviewOpen()
				end,
				"Open DiffView against HEAD",
			},
			["<leader>db"] = {
				function()
					vim.ui.input({ prompt = "Branch to diff against" }, function(search)
						vim.cmd.DiffviewOpen(search)
					end)
				end,
				"Open DiffView against a given branch",
			},
			["<leader>dc"] = {
				function()
					vim.cmd.DiffviewClose()
				end,
				"Close DiffView",
			},
			["<leader>df"] = {
				function()
					vim.cmd.DiffviewToggleFiles()
				end,
				"Toggle DiffView file panel",
			},
		}),

		generate({
			name = "Terminal",
			["<leader>`"] = {
				function()
					toggle_term:toggle()
				end,
				"Toggle the floating term",
			},
		}),

		generate({
			name = "Movement",
			["<A-k>"] = {
				function()
					require("moveline").block_up()
				end,
				"Up",
			},
			["<A-j>"] = {
				function()
					require("moveline").block_down()
				end,
				"Down",
			},
		}, { mode = "v" }),

		generate({
			name = "Close buffers",
			["<leader>bc"] = {
				function()
					local buffers = vim.api.nvim_list_bufs()
					local current_buf = vim.api.nvim_get_current_buf()
					for _, buffer_number in pairs(buffers) do
						local listed = vim.fn.buflisted(buffer_number)
						if listed == 1 and buffer_number ~= current_buf then
							vim.cmd.bd(buffer_number)
						end
					end
				end,
				"Do the thing",
			},
		}),

		generate({
			name = "Inlay Hints",
			["<leader>ih"] = {
				require("lsp-inlayhints").toggle,
				"Toggle",
			},
		}),

		generate({
			name = "hop hint",
			["<leader>o"] = {
				function()
					require("hop").hint_words()
				end,
				"Show Hop hints",
			},
		}),
	}
end

return M
