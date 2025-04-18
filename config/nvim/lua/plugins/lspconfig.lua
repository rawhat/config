return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"elixir-tools/elixir-tools.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local utils = require("utils")
		local path = require("mason-core.path")
		local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

		-- when in a deno project, we need to disable tsserver single_file_support
		lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
			local cwd = utils.cwd()
			if config.name == "vtsls" and vim.fn.filereadable(cwd .. "/deno.jsonc") == 1 then
				config.single_file_support = false
			end
			if config.name == "gopls" and vim.fn.filereadable(cwd .. "/WORKSPACE") ~= 1 then
				config.settings.cmd_env = {}
			end
		end)

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		local lsp_configs = {
			astro = {},
			basedpyright = {
				flags = { debounce_text_changes = 300 },
				settings = {
					python = {
						analysis = {
							extra_paths = { utils.cwd() },
						},
					},
				},
			},
			bashls = {},
			biome = {},
			buf_ls = {},
			clangd = {
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			},
			clojure_lsp = {},
			crystalline = {},
			docker_compose_language_service = {},
			dockerls = {},
			elp = {},
			erlangls = {},
			fsautocomplete = {},
			gleam = {},
			gopls = {
				settings = {
					cmd_env = {
						GOPACKAGESDRIVER = "./gopackagesdriver.sh",
						GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
					},
					gopls = {
						directoryFilters = {
							"-bazel-bin",
							"-bazel-out",
							"-bazel-testlogs",
							"-bazel-vistar",
							-- "-bazel-app",
						},
						env = {
							GOPACKAGESDRIVER = "./gopackagesdriver.sh",
							GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						["ui.semanticTokens"] = true,
						workspaceFiles = {
							"**/BUILD",
							"**/WORKSPACE",
							"**/*.{bzl,bazel}",
						},
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
				settings = {
					Lua = {
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			},
			ocamllsp = {
				settings = {
					["ocaml.server.extraEnv"] = {
						["OCAMLLSP_SEMANTIC_HIGHLIGHTING"] = "full",
					},
				},
			},
			sorbet = {},
			sqlls = {},
			starpls = {},
			taplo = {},
			vtsls = {
				settings = {
					complete_function_calls = true,
					typescript = {
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
						tsserver = {
							maxTsServerMemory = 8192,
						},
					},
				},
			},
			zls = {},
		}

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls" },
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		})

		for server, config in pairs(lsp_configs) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities, true)
			require("lspconfig")[server].setup(config)
		end

		-- local java_language_server
		if vim.fn.has("mac") == 1 then
			java_language_server = "/Users/amanning/java-language-server/dist/lang_server_mac.sh"
		else
			java_language_server = "/home/alex/java-language-server/dist/lang_server_linux.sh"
		end

		-- non-lsp-install servers
		require("lspconfig").java_language_server.setup({
			cmd = { java_language_server },
		})

		vim.g.rustaceanvim = {
			capabilities = capabilities,
			tools = {
				inlay_hints = {
					auto = false,
				},
			},
			server = {
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
		}

		local elixir = require("elixir")
		local elixirls = require("elixir.elixirls")
		elixir.setup({
			credo = {
				enable = true,
			},
			elixirls = {
				cmd = path.concat({ mason_data_path, "elixir-ls" }),
				enable = true,
				settings = elixirls.settings({
					dialyzerEnabled = false,
					enableTestLenses = false,
				}),
			},
			nextls = {
				cmd = path.concat({ mason_data_path, "elixir-ls" }),
				enable = true,
				init_options = {
					experimental = {
						completions = {
							enable = true,
						},
					},
				},
			},
			projectionist = {
				enable = true,
			},
		})

		if utils.has("0.10.0") then
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
			})
		else
			-- show lsp signs in gutter
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end

		-- i don't want virtual text for LSP diagnostics.  but the lsp installer plugin
		-- uses diagnostics for displaying information!  so just disable it in the
		-- handler
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
		})
	end,
}
