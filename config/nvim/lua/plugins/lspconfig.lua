local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")
local configs = require("lspconfig.configs")
local wk = require("which-key")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_servers = {
	"clangd",
	"crystalline",
	"elixirls",
	"erlangls",
	"eslint",
	"fsautocomplete",
	"gopls",
	"jsonls",
	"jsonnet_ls",
	"ocamllsp",
	"pyright",
	"rust_analyzer",
	"sorbet",
	"sumneko_lua",
	"tsserver",
	"zls",
}

lsp_installer.setup({
	ensure_installed = lsp_servers,
	icons = {
		server_installed = "✓",
		server_pending = "➜",
		server_uninstalled = "✗",
	},
})

local bind_lsp_format = function()
	wk.register({
		["<leader><space>f"] = {
			function()
				vim.lsp.buf.format()
			end,
			"Format with lsp",
		},
	})
end

local aerial_attach = function(client, buf_nr)
	require("aerial").on_attach(client, buf_nr)
end
local noop = function() end

for _, server in pairs(lsp_servers) do
	local config = {
		capabilities = capabilities,
		on_attach = aerial_attach,
	}
	if server == "elixirls" then
		config.filetypes = { "elixir", "leex", "heex", "eex" }
		config.on_attach = function(client, buf_nr)
			aerial_attach(client, buf_nr)
			bind_lsp_format()
		end
	elseif server == "pyright" then
		config.root_dir = function(fname)
			return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
				fname
			) -- or lspconfig.util.path.dirname(fname)
		end
		config.flags = { debounce_text_changes = 300 }
		config.settings = {
			python = {
				analysis = {
					diagnosticMode = "openFilesOnly",
				},
			},
		}
	elseif server == "rust_analyzer" then
		config.on_attach = function(client, buf_nr)
			aerial_attach(client, buf_nr)
			bind_lsp_format()
			require("virtualtypes").on_attach(client)
		end
		config.settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
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
			aerial_attach(client, buf_nr)
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
			aerial_attach(client, buf_nr)
			bind_lsp_format()
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
		config.on_attach = function(client, buf_nr)
			aerial_attach(client, buf_nr)
			bind_lsp_format()
		end
	elseif server == "gleam" then
		config.on_attach = function(client, buf_nr)
			aerial_attach(client, buf_nr)
			bind_lsp_format()
		end
	elseif server == "erlangls" then
		config.on_attach = function(client, buf_nr)
			aerial_attach(client, buf_nr)
			bind_lsp_format()
		end
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
				bind_lsp_format()
			end,
			root_dir = function(fname)
				return lspconfig.util.root_pattern("gleam.toml")(fname)
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

local typescript_javascript = {
	pattern = { ".ts", ".tsx", ".js", ".jsx" },
	command = {
		-- npm install -g @fsouza/prettierd
		exe = "prettierd",
		get_args = function()
			return { vim.api.nvim_buf_get_name(0) }
		end,
		stdin = true,
	},
}
-- filetypes that use `formatter.nvim` instead of lsp
local formatter_filetypes = {
	bzl = {
		pattern = { ".bzl", "BUILD", "WORKSPACE" },
		command = {
			-- go install github.com/bazelbuild/buildtools/buildifier@latest
			exe = "buildifier",
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
		pattern = { ".lua" },
		command = {
			-- available on package manager (or cargo)
			exe = "stylua",
			get_args = function()
				return { "-" }
			end,
			stdin = true,
		},
	},
	python = {
		pattern = { ".python" },
		command = {
			-- pip install --user pyfmt
			exe = "pyfmt",
			get_args = function()
				return { vim.api.nvim_buf_get_name(0) }
			end,
			stdin = true,
		},
	},
	json = {
		pattern = { ".json" },
		command = {
			-- available on package manager
			exe = "jq",
			stdin = true,
		},
	},
}

local formatter_opts = {}
local format_group = vim.api.nvim_create_augroup("FormatterFiletypes", { clear = true })
for name, tbl in pairs(formatter_filetypes) do
	vim.api.nvim_create_autocmd({ "BufReadPre" }, {
		patterns = tbl.patterns,
		callback = function()
			wk.register({
				["<leader><space>f"] = {
					"<cmd>Format<cr>",
					"Format with formatter.nvim",
				},
			})
		end,
		group = format_group,
		desc = "Format for " .. name,
	})

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
