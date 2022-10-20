local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local wk = require("which-key")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_servers = {
	"clangd",
	"clojure_lsp",
	"crystalline",
	"elixirls",
	"erlangls",
	-- "eslint",
	"fsautocomplete",
	"gopls",
	"jsonls",
	"jsonnet_ls",
	"ocamllsp",
	"pyright",
	"rust_analyzer",
	"sorbet",
	"sqls",
	"sumneko_lua",
	-- "tailwindcss",
	"tsserver",
	"zls",
}

require("mason-lspconfig").setup({
	ensure_installed = lsp_servers,
	icons = {
		server_installed = "✓",
		server_pending = "➜",
		server_uninstalled = "✗",
	},
})

local aerial = require("aerial")
local aerial_attach = function(client, buf_nr)
	aerial.on_attach(client, buf_nr)
end

local on_attach = function(client, buf_nr)
	aerial_attach(client, buf_nr)
end

for _, server in pairs(lsp_servers) do
	local config = {
		capabilities = capabilities,
		root_dir = function()
			return vim.fn.getcwd()
		end,
	}
	if server == "elixirls" then
		config.filetypes = { "elixir", "leex", "heex", "eex" }
		config.on_attach = on_attach
	elseif server == "pyright" then
		config.flags = { debounce_text_changes = 300 }
		config.settings = {
			python = {
				analysis = {
					diagnosticMode = "openFilesOnly",
				},
			},
		}
		config.on_attach = on_attach
	elseif server == "rust_analyzer" then
		config.on_attach = function(client, buf_nr)
			on_attach(client, buf_nr)
			require("virtualtypes").on_attach(client)
		end
		config.settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
				diagnostics = {
					experimental = {
						enable = true,
					},
				},
			},
		}
	elseif server == "tsserver" then
		config.init_options = require("nvim-lsp-ts-utils").init_options
		config.flags = {
			debounce_text_changes = 150,
		}
		config.filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		}
		config.on_attach = function(client, buf_nr)
			on_attach(client, buf_nr)
			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			ts_utils.setup_client(client)
		end
		config.commands = {
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
		}
	elseif server == "ocamlls" then
		config.on_attach = function(client)
			on_attach(client, buf_nr)
			require("virtualtypes").on_attach(client)
		end
	elseif server == "gopls" then
		config.settings = {
			go = {
				toolsEnvVars = {
					GOPACKAGESDRIVER = "${workspaceFolder}/tools/gopackagesdriver.sh",
				},
			},
			build = {
				directoryFilters = {
					"-bazel-bin",
					"-bazel-out",
					"-bazel-testlogs",
					"-bazel-mypkg",
				},
			},
		}
		config.flags = {
			debounce_text_changes = 150,
		}
		config.on_attach = on_attach
	elseif server == "erlangls" then
		config.on_attach = on_attach
	elseif server == "sqls" then
		config.on_attach = on_attach
	elseif server == "sumneko_lua" then
		config.root_dir = require("lspconfig").sumneko_lua.root_dir
		config.on_attach = on_attach
	end

	lspconfig[server].setup(config)
end

-- non-lsp-install servers
lspconfig.java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

if not configs.gleam then
	configs.gleam = {
		default_config = {
			cmd = { "gleam", "lsp" },
			filetypes = { "gleam" },
			on_attach = function(client, buf_nr)
				aerial_attach(client, buf_nr)
			end,
			root_dir = function(_fname)
				return vim.fn.getcwd()
			end,
		},
	}
end
lspconfig.gleam.setup({})

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
local format_group = vim.api.nvim_create_augroup("FormatterFiletypes", { clear = true })
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

local lsp_format_filetypes = {
	["elixir"] = true,
	["gleam"] = true,
	["go"] = true,
	-- ["java"] = true, -- v broken
}
for _, ft in pairs(lsp_servers) do
	if formatter_filetypes[ft] == nil then
		lsp_format_filetypes[ft] = true
	end
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
	["<leader><space>f"] = {
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
