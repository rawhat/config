local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local utils = require("utils")

-- when in a deno project, we need to disable tsserver single_file_support
lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
	local cwd = utils.cwd()
	if config.name == "tsserver" and vim.fn.filereadable(cwd .. "/deno.jsonc") == 1 then
		config.single_file_support = false
	end
	if config.name == "gopls" and vim.fn.filereadable(cwd .. "/WORKSPACE") ~= 1 then
		config.settings = {}
	end
end)

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

configs.bzl = {
	default_config = {
		cmd = { "bzl", "lsp" },
		filetypes = { "bzl" },
		root_dir = function(fname)
			return utils.cwd()
		end,
	},
}

local lsp_configs = {
	bashls = {},
	bzl = {},
	biome = {},
	bufls = {},
	clangd = {
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	},
	clojure_lsp = {},
	crystalline = {},
	elixirls = {
		filetypes = { "elixir", "leex", "heex", "eex" },
	},
	elp = {},
	erlangls = {},
	fsautocomplete = {},
	gleam = {},
	gopls = {
		on_new_config = function(config, new_root_dir)
			local gopackagesdriver = new_root_dir .. "/gopackagesdriver.sh"
			if utils.fs_stat(gopackagesdriver) ~= nil then
				config.cmd_env = {
					GOPACKAGESDRIVER = gopackagesdriver,
					GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
				}
			end
		end,
		settings = {
			gopls = {
				directoryFilters = {
					"-bazel-bin",
					"-bazel-out",
					"-bazel-testlogs",
					"-bazel-vistar",
					"-bazel-app",
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				staticcheck = true,
			},
		},
		flags = {
			debounce_text_changes = 150,
		},
	},
	html = {},
	jsonls = {},
	jsonnet_ls = {},
	lua_ls = {
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if not utils.fs_stat(path .. "/.luarc.json") and not utils.fs_stat(path .. "/.luarc.jsonc") then
				client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						library = { vim.env.VIMRUNTIME },
					},
				})
			end
			return true
		end,
		settings = {
			Lua = {
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
	ocamllsp = {},
	pyright = {
		flags = { debounce_text_changes = 300 },
		settings = {
			python = {
				analysis = {
					diagnosticMode = "openFilesOnly",
					extra_paths = { utils.cwd() },
				},
			},
		},
	},
	sorbet = {},
	sqlls = {},
	taplo = {},
	zls = {},
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
	local on_attach = config.on_attach
	config.on_attach = function(client, bufnr)
		if on_attach ~= nil then
			on_attach(client, bufnr)
		end
	end
	config.capabilities = capabilities
	require("lspconfig")[server].setup(config)
end

-- non-lsp-install servers
require("lspconfig").java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

require("deno-nvim").setup({
	server = {
		on_attach = function(client)
			local active_clients = vim.lsp.get_clients()
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

require("rust-tools").setup({
	server = {
		capabilities = capabilities,
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
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
})

require("typescript-tools").setup({
	capabilities = capabilities,
	root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		local active_clients = vim.lsp.get_clients()
		for _, running_client in pairs(active_clients) do
			if running_client.name == "denols" then
				client.stop()
			end
		end
	end,
	settings = {
		tsserver_file_preferences = {
			includeInlayEnumMemberValueHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
		},
	},
})

-- show lsp signs in gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- i don't want virtual text for LSP diagnostics.  but the lsp installer plugin
-- uses diagnostics for displaying information!  so just disable it in the
-- handler
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
})
