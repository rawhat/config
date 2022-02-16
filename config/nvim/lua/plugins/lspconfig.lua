local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local noop = function() end
local on_attach = function(fn)
	return function(client)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		fn(client)
	end
end

lsp_installer.on_server_ready(function(server)
	local config = {
		capabilities = capabilities,
		on_attach = on_attach(noop),
	}

	if server.name == "elixirls" then
		table.insert(config, {
			filetypes = { "elixir", "leex", "heex", "eex" },
		})
	elseif server.name == "pyright" then
		table.insert(config, {
			root_dir = function(fname)
				return lspconfig.util.root_pattern(
					".git",
					"setup.py",
					"setup.cfg",
					"pyproject.toml",
					"requirements.txt"
				)(fname) -- or lspconfig.util.path.dirname(fname)
			end,
			flags = { debounce_text_changes = 300 },
			settings = {
				python = {
					analysis = {
						diagnosticMode = "openFilesOnly",
					},
				},
			},
		})
	elseif server.name == "rust_analyzer" then
		table.insert(config, {
			on_attach = on_attach(function(client)
				require("virtualtypes").on_attach(client)
			end),
			settings = {
				["rust-analyzer"] = {
					checkOnSave = { command = "clippy" },
				},
			},
		})
	elseif server.name == "tsserver" then
		table.insert(config, {
			init_options = require("nvim-lsp-ts-utils").init_options,
			flags = {
				debounce_text_changes = 150,
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			on_attach = on_attach(function(client)
				local ts_utils = require("nvim-lsp-ts-utils")
				ts_utils.setup({})
				ts_utils.setup_client(client)
			end),
		})
	elseif server.name == "ocamlls" then
		table.insert(config, {
			on_attach = on_attach(function(client)
				require("virtualtypes").on_attach(client)
			end),
		})
	elseif server.name == "gopls" then
		table.insert(config, {
			settings = {
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
			},
			flags = {
				debounce_text_changes = 150,
			},
		})
	end

	server:setup(config)
end)

-- non-lsp-install servers
lspconfig.java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

-- right now this is installed manually
lspconfig.fsautocomplete.setup({})

vim.cmd([[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]])

-- show lsp signs in gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
