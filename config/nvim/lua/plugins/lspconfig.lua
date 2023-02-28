local configs = require("lspconfig.configs")
local wk = require("which-key")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_configs = {
	clangd = {
		capabilities = capabilities,
	},
	clojure_lsp = {
		capabilities = capabilities,
	},
	crystalline = {
		capabilities = capabilities,
	},
	elixirls = {
		capabilities = capabilities,
		filetypes = { "elixir", "leex", "heex", "eex" },
	},
	erlangls = {
		capabilities = capabilities,
	},
	fsautocomplete = {
		capabilities = capabilities,
	},
	gopls = {
		capabilities = capabilities,
		settings = {
			gopls = {
				env = {
					GOPACKAGESDRIVER = "/home/alex/bin/gopackagesdriver",
				},
				directoryFilters = {
					"-bazel-bin",
					"-bazel-out",
					"-bazel-testlogs",
					"-bazel-vistar",
					"-bazel-app",
				},
			},
		},
		flags = {
			debounce_text_changes = 150,
		},
	},
	jsonls = {
		capabilities = capabilities,
	},
	jsonnet_ls = {
		capabilities = capabilities,
	},
	lua_ls = {
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
	ocamllsp = {
		capabilities = capabilities,
		on_attach = function(client)
			require("virtualtypes").on_attach(client)
		end,
	},
	pyright = {
		capabilities = capabilities,
		flags = { debounce_text_changes = 300 },
		settings = {
			python = {
				analysis = {
					diagnosticMode = "openFilesOnly",
				},
			},
		},
	},
	rust_analyzer = {
		capabilities = capabilities,
		on_attach = function(client)
			require("virtualtypes").on_attach(client)
		end,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
				diagnostics = {
					experimental = {
						enable = true,
					},
				},
			},
		},
	},
	sorbet = {
		capabilities = capabilities,
	},
	sqls = {
		capabilities = capabilities,
	},
	tsserver = {
		command = { "typescript-language-server", "--stdio" },
		capabilities = capabilities,
		root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
		init_options = require("nvim-lsp-ts-utils").init_options,
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = function(client)
			local active_clients = vim.lsp.get_active_clients()
			for _, running_client in pairs(active_clients) do
				if running_client.name == "denols" then
					client.stop()
				end
			end
			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			ts_utils.setup_client(client)
		end,
		commands = {
			OrganizeImports = {
				function()
					vim.lsp.buf.execute_command({
						command = "_typescript.organizeImports",
						arguments = { vim.api.nvim_buf_get_name(0) },
						title = "",
					})
				end,
				description = "Organize Imports",
			},
		},
	},
	zls = {
		capabilities = capabilities,
	},
}

local lsp_servers = {}
for server, _ in pairs(lsp_servers) do
	table.insert(lsp_servers, server)
end

require("mason-lspconfig").setup({
	ensure_installed = lsp_servers,
	icons = {
		server_installed = "✓",
		server_pending = "➜",
		server_uninstalled = "✗",
	},
})

for server, config in pairs(lsp_configs) do
	require("lspconfig")[server].setup(config)
end
-- non-lsp-install servers
require("lspconfig").java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

require("deno-nvim").setup({
	server = {
		on_attach = function(client)
			local active_clients = vim.lsp.get_active_clients()
			for _, running_client in pairs(active_clients) do
				if running_client.name == "tsserver" then
					client.stop()
				end
			end
		end,
		capabilities = capabilities,
		root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc", "denonvim.tag"),
		settings = {
			deno = {
				unstable = true,
			},
		},
	},
})

if not configs.gleam then
	configs.gleam = {
		default_config = {
			cmd = { "gleam", "lsp" },
			filetypes = { "gleam" },
			on_attach = function(client)
				client.server_capabilities.completionProvider = false
			end,
			root_dir = function()
				return vim.fn.getcwd()
			end,
		},
	}
end
require("lspconfig").gleam.setup({})

-- show lsp signs in gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local ends_with = function(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

local path = require("mason-core.path")
local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })
local util = require("formatter.util")

local typescript_javascript = {
	command = {
		exe = path.concat({ mason_data_path, "prettier" }),
		get_args = function()
			return {
				"--stdin-filepath",
				util.escape_path(util.get_current_buffer_file_path()),
			}
		end,
		stdin = true,
	},
}

-- filetypes that use `formatter.nvim` instead of lsp
local formatter_filetypes = {
	bzl = {
		command = {
			exe = path.concat({ mason_data_path, "buildifier" }),
			get_args = function()
				local filename = vim.fn.expand("%:t")
				if filename == "BUILD" then
					return { "--type=build" }
				elseif filename == "WORKSPACE" then
					return { "--type=workspace" }
				elseif ends_with(filename, ".bzl") then
					return { "--type=bzl" }
				else
					return { "--type=default" }
				end
			end,
			stdin = true,
		},
	},
	typescript = typescript_javascript,
	typescriptreact = typescript_javascript,
	javascript = typescript_javascript,
	javascriptreact = typescript_javascript,
	lua = {
		command = {
			exe = path.concat({ mason_data_path, "stylua" }),
			get_args = function()
				return { "-" }
			end,
			stdin = true,
		},
	},
	python = {
		command = {
			-- pip install --user pyfmt
			exe = "bazel",
			get_args = function()
				return { "run", "//tools/pyfmt", "--", "-i", vim.fn.expand("%:p") }
			end,
			stdin = false,
		},
	},
	json = {
		command = {
			-- available on package manager
			exe = path.concat({ mason_data_path, "jq" }),
			stdin = true,
		},
	},
}

local formatter_opts = {}
for name, tbl in pairs(formatter_filetypes) do
	if vim.fn.executable(tbl.command.exe) == 0 then
		error(tbl.command.exe .. " not found on path")
	end

	formatter_opts[name] = {
		function()
			local args
			if tbl.command.get_args ~= nil then
				args = tbl.command.get_args()
			else
				args = {}
			end
			return {
				exe = tbl.command.exe,
				args = args,
				stdin = tbl.command.stdin,
			}
		end,
	}
end

require("formatter").setup({
	filetype = formatter_opts,
})

local lsp_filetypes = {
	"c",
	"clojure",
	"cpp",
	"crystal",
	"elixir",
	"erlang",
	"fsharp",
	"gleam",
	"go",
	"jsonnet",
	"lua",
	"ocaml",
	"ruby",
	"rust",
	"sql",
	"zig",
}

local lsp_format_filetypes = {}
for _, filetype in pairs(lsp_filetypes) do
	lsp_format_filetypes[filetype] = true
end

local function format(write)
	local current_buf = vim.api.nvim_get_current_buf()
	local ft = vim.api.nvim_buf_get_option(current_buf, "filetype")
	if formatter_filetypes[ft] ~= nil then
		local op = "Format"
		if write then
			op = op .. "Write"
		end
		vim.cmd(op .. "Lock")
	elseif lsp_format_filetypes[ft] ~= nil then
		local timeout = write and 1000 or nil
		local opts = { async = true, timeout_ms = timeout }
		if write then
			opts.async = false
		end
		vim.lsp.buf.format(opts)
	end
end

wk.register({
	["<leader>F"] = {
		format,
		"Format the current buffer",
	},
})

-- i don't want virtual text for LSP diagnostics.  but the lsp installer plugin
-- uses diagnostics for displaying information!  so just disable it in the
-- handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
})

local format_on_save = vim.api.nvim_create_augroup("LanguageFormats", { clear = true })

-- This annoyling errors when `:wq`.  I'm not sure why yet, and I don't really
-- feel like digging more into this at the moment.
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		format(true)
	end,
	group = format_on_save,
})
