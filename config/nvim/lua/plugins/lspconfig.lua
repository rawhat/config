local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")
local configs = require("lspconfig.configs")
local wk = require("which-key")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local bind_lsp_format = function()
	wk.register({
		["<leader><space>f"] = {
			function()
				vim.lsp.buf.formatting_sync()
			end,
			"Format with lsp",
		},
	})
end
local noop = function() end

lsp_installer.on_server_ready(function(server)
	local config = {
		capabilities = capabilities,
		on_attach = noop,
	}

	if server.name == "elixirls" then
		config.filetypes = { "elixir", "leex", "heex", "eex" }
		config.on_attach = function()
			bind_lsp_format()
		end
	elseif server.name == "pyright" then
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
	elseif server.name == "rust_analyzer" then
		config.on_attach = function(client)
			bind_lsp_format()
			require("virtualtypes").on_attach(client)
		end
		config.settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
			},
		}
	elseif server.name == "tsserver" then
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
		config.on_attach = function(client)
			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			ts_utils.setup_client(client)
		end
	elseif server.name == "ocamlls" then
		config.on_attach = function(client)
			bind_lsp_format()
			require("virtualtypes").on_attach(client)
		end
	elseif server.name == "gopls" then
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
	end

	server:setup(config)
end)

-- non-lsp-install servers
lspconfig.java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

if not configs.gleam then
	configs.gleam = {
		default_config = {
			cmd = { "gleam", "lsp" },
			filetypes = { "gleam" },
			on_attach = function()
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

-- filetypes that use `formatter.nvim` instead of lsp
local formatter_filetypes = {
	typescript = {
		pattern = { ".ts", ".tsx", ".js", ".jsx" },
		command = {
			-- npm install -g @fsouza/prettierd
			exe = "prettierd",
			args = { vim.api.nvim_buf_get_name(0) },
			stdin = true,
		},
	},
	lua = {
		pattern = { ".lua" },
		command = {
			-- available on package manager (or cargo)
			exe = "stylua",
			args = { "-" },
			stdin = true,
		},
	},
	python = {
		pattern = { ".python" },
		command = {
			-- pip install --user pyfmt
			exe = "pyfmt",
			args = { vim.api.nvim_buf_get_name(0) },
			stdin = true,
		},
	},
	json = {
		pattern = { ".json" },
		command = {
			-- available on package manager
			exe = "jq",
			args = {},
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
			return tbl.command
		end,
	}
end

require("formatter").setup({
	filetype = formatter_opts,
})
