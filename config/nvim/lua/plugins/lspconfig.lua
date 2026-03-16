return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"mason-org/mason.nvim",
		"elixir-tools/elixir-tools.nvim",
		{ "mrcjkb/rustaceanvim", ft = { "rust" }, lazy = false },
	},
	config = function()
		local path = require("mason-core.path")
		local utils = require("utils")
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
			---@type lspconfig.settings.bashls
			bashls = {},
			---@type lspconfig.settings.buf_ls
			buf_ls = {},
			---@type lspconfig.settings.docker_compose_language_service
			docker_compose_language_service = {},
			---@type lspconfig.settings.dockerls
			dockerls = {},
			---@type lspconfig.settings.elp
			elp = {},
			---@type lspconfig.settings.gdscript
			gdscript = {},
			---@type lspconfig.settings.gleam
			gleam = {},
			---@type lspconfig.settings.gopls
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
			---@type lspconfig.settings.htlm
			html = {},
			---@type lspconfig.settings.java_language_server
			java_language_server = {
				cmd = { "java-language-server" },
			},
			---@type lspconfig.settings.jsonls
			jsonls = {},
			---@type lspconfig.settings.jsonnet_ls
			jsonnet_ls = {},
			---@type lspconfig.settings.lua_ls
			lua_ls = {
				on_attach = function(client)
					client.server_capabilities.formatting = false
					client.server_capabilities.rangeFormatting = false
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
			---@type lspconfig.settings.rust_analyzer
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
			---@type lspconfig.settings.sqlls
			sqlls = {},
			---@type lspconfig.settings.starpls
			starpls = {},
			---@type lspconfig.settings.stylua
			stylua = {},
			---@type lspconfig.settings.tailwindcss
			tailwindcss = {},
			---@type lspconfig.settings.taplo
			taplo = {},
			---@type lspconfig.settings.ts_ls
			tsgo = {
				cmd_env = {
					GOMEMLIMIT = "2048MiB",
				},
				filetypes = {
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "non-relative",
					},
				},
			},
			---@type lspconfig.settings.ty
			ty = {},
			---@type lspconfig.settings.vtsls
			vtsls = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
				},
			},
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
