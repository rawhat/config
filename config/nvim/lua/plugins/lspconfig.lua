return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"mason-org/mason.nvim",
		"elixir-tools/elixir-tools.nvim",
		{ "mrcjkb/rustaceanvim", version = "^6", ft = { "rust" }, lazy = false },
	},
	config = function()
		local utils = require("utils")
		local path = require("mason-core.path")
		local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

		require("mason-lspconfig").setup({
			automatic_enable = false,
			ensure_installed = { "lua_ls" },
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		})

		local lsp_configs = {
			astro = {},
			basedpyright = {
				flags = { debounce_text_changes = 300 },
				settings = {
					basedpyright = {
						defineConstant = {
							DEBUG = true,
						},
						exclude = {},
						include = { "traffficking" },
						pythonVersion = "3.13",
						typeCheckingMode = "basic",
					},
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
			coffeesense = {},
			crystalline = {},
			docker_compose_language_service = {},
			dockerls = {},
			elp = {},
			erlangls = {},
			fsautocomplete = {},
			gleam = {},
			gopls = {
				on_new_config = function(config, new_root_dir)
					local gopackagesdriver = new_root_dir .. "/gopackagesdriver.sh"
					local stat = utils.fs_stat(gopackagesdriver)
					if not stat or stat.type ~= "file" then
						return
					end
					config.cmd_env = {
						GOPACKAGESDRIVER = gopackagesdriver,
						GOPACKAGESDRIVER_BAZEL_BUILD_FLAGS = "--strategy=GoStdlibList=local",
					}
				end,
				settings = {
					gopls = {
						directoryFilters = {
							"-bazel-bin",
							"-bazel-out",
							"-bazel-testlogs",
							"-bazel-vistar",
							"-bazel-app",
							"-bazel-supersonic",
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
			java_language_server = {
				cmd = { "java-language-server" },
			},
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
			-- pyrefly = {},
			["rust-analyzer"] = {
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
			sorbet = {},
			sqlls = {},
			starpls = {},
			tailwindcss = {},
			taplo = {},
			tsgo = {
				cmd = { "tsgo", "--lsp", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
			},
			-- ty = {},
			-- ts_ls = {},
			-- vtsls = {
			-- 	settings = {
			-- 		complete_function_calls = true,
			-- 		typescript = {
			-- 			suggest = {
			-- 				completeFunctionCalls = true,
			-- 			},
			-- 			inlayHints = {
			-- 				parameterNames = { enabled = "literals" },
			-- 				parameterTypes = { enabled = true },
			-- 				variableTypes = { enabled = true },
			-- 				propertyDeclarationTypes = { enabled = true },
			-- 				functionLikeReturnTypes = { enabled = true },
			-- 				enumMemberValues = { enabled = true },
			-- 			},
			-- 			tsserver = {
			-- 				maxTsServerMemory = 8192,
			-- 			},
			-- 		},
			-- 	},
			-- },
			zls = {},
		}

		vim.g.rustaceanvim = {
			tools = {
				inlay_hints = {
					auto = false,
				},
			},
		}

		for server, config in pairs(lsp_configs) do
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end

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
				cmd = path.concat({ mason_data_path, "nextls" }),
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

		-- i don't want virtual text for LSP diagnostics.  but mason uses
		-- diagnostics for displaying information!  so just disable it in the
		-- handler
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, params, ctx)
			params = vim.tbl_extend("force", params, { virtual_text = false })
			return vim.lsp.diagnostic.on_publish_diagnostics(err, params, ctx)
		end
	end,
}
