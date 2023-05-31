local lspconfig = require("lspconfig")
local null = require("null-ls")
local path = require("mason-core.path")
local wk = require("which-key")
local inlay_hints = require("lsp-inlayhints")

-- when in a deno project, we need to disable tsserver single_file_support
lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
	local cwd = vim.loop.cwd()
	if config.name == "tsserver" and vim.fn.filereadable(cwd .. "/deno.jsonc") == 1 then
		config.single_file_support = false
	end
	if config.name == "gopls" and vim.fn.filereadable(cwd .. "/WORKSPACE") ~= 1 then
		config.settings = {}
	end
end)

local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_configs = {
	clangd = {
		capabilities = capabilities,
		on_attach = inlay_hints.on_attach,
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
		on_attach = inlay_hints.on_attach,
	},
	gleam = {
		capabilities = capabilities,
	},
	gopls = {
		capabilities = capabilities,
		on_attach = inlay_hints.on_attach,
		settings = {
			gopls = {
				env = {
					GOPACKAGESDRIVER = "/home/alex/gopackagesdriver",
				},
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
			},
		},
		flags = {
			debounce_text_changes = 150,
		},
	},
	html = {
		capabilities = capabilities,
	},
	jsonls = {
		capabilities = capabilities,
	},
	jsonnet_ls = {
		capabilities = capabilities,
	},
	lua_ls = {
		capabilities = capabilities,
		on_attach = inlay_hints.on_attach,
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
				hint = {
					enable = true,
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
	sorbet = {
		capabilities = capabilities,
	},
	sqlls = {
		capabilities = capabilities,
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

local format_group = vim.api.nvim_create_augroup("LspFormatting", {})

local format_filter = function(client)
	return not vim.tbl_contains({ "tsserver", "lua_ls", "pyright" }, client.name)
end

local on_attach_format = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = format_filter,
				})
			end,
		})
		wk.register({
			["<leader>f"] = {
				function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = format_filter,
					})
				end,
				"LSP Format",
			},
		})
	end
end

local helpers = require("null-ls.helpers")
local pyfmt = {
	method = null.methods.FORMATTING,
	filetypes = { "python" },
	generator = helpers.formatter_factory({
		args = { "run", "//tools/pyfmt" },
		command = "bazel",
		timeout = 5000,
		to_stdin = true,
	}),
	condition = function(utils)
		return utils.root_has_file({ "WORKSPACE" })
	end,
}
local java_format = {
	method = null.methods.FORMATTING,
	filetypes = { "java" },
	generator = helpers.formatter_factory({
		args = { "run", "//tools/java-format", "--", "--stdin" },
		command = "bazel",
		timeout = 5000,
		to_stdin = true,
	}),
}
local coffeelint = {
	method = null.methods.DIAGNOSTICS,
	filetypes = { "coffee" },
	generator = helpers.generator_factory({
		args = { "-s", "--reporter", "raw", "--nocolor", "--quiet" },
		command = "coffeelint",
		format = "json",
		from_stderr = true,
		to_stdin = true,
		on_output = function(params)
			local matcher = helpers.diagnostics.from_pattern(
				"%[stdin%]:(%d+):(%d+):[%s*]error: (.-)\n.*",
				{ "row", "col", "message" }
			)
			local output = params.output.stdin or {}
			local diagnostics = {}
			for _, diagnostic in pairs(output) do
				local parsed = matcher(diagnostic.message, {})
				if parsed ~= nil then
					local value = {
						row = tonumber(parsed.row),
						col = tonumber(parsed.col),
						message = parsed.message,
					}
					table.insert(diagnostics, value)
				end
			end
			return diagnostics
		end,
	}),
}
local prettify = {
	method = null.methods.FORMATTING,
	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "javascript.jsx", "typescript.tsx" },
	generator = helpers.formatter_factory({
		args = { "run", "//tools/prettier", "--", "--stdin-filepath", "$FILENAME" },
		command = "bazel",
		timeout = 5000,
		to_stdin = true,
	}),
	condition = function(utils)
		return utils.root_has_file({ "WORKSPACE" })
	end,
}

null.setup({
	sources = {
		null.builtins.code_actions.eslint_d.with({
			command = path.concat({ mason_data_path, "eslint_d" }),
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc*" })
			end,
		}),

		null.builtins.diagnostics.buildifier.with({
			command = path.concat({ mason_data_path, "buildifier" }),
		}),
		coffeelint,
		null.builtins.diagnostics.credo,
		null.builtins.diagnostics.eslint_d.with({
			command = path.concat({ mason_data_path, "eslint_d" }),
			condition = function(utils)
				return utils.root_has_file({ ".eslintrc*" })
			end,
		}),
		null.builtins.diagnostics.fish,
		null.builtins.diagnostics.ruff.with({
			command = path.concat({ mason_data_path, "ruff" }),
		}),

		null.builtins.formatting.black.with({
			command = path.concat({ mason_data_path, "black" }),
			condition = function(utils)
				return not utils.root_has_file({ "WORKSPACE" })
			end,
		}),
		null.builtins.formatting.buildifier.with({
			command = path.concat({ mason_data_path, "buildifier" }),
		}),
		null.builtins.formatting.fish_indent,
		java_format,
		null.builtins.formatting.jq,
		null.builtins.formatting.just,
		null.builtins.formatting.prettier.with({
			command = path.concat({ mason_data_path, "prettier" }),
			condition = function(utils)
				return not utils.root_has_file({ "WORKSPACE" })
			end,
		}),
		prettify,
		pyfmt,
		null.builtins.formatting.stylua.with({
			command = path.concat({ mason_data_path, "stylua" }),
		}),
	},
	on_attach = on_attach_format,
})

for server, config in pairs(lsp_configs) do
	local on_attach = config.on_attach
	config.on_attach = function(client, bufnr)
		if on_attach ~= nil then
			on_attach(client, bufnr)
		end
		on_attach_format(client, bufnr)
	end
	require("lspconfig")[server].setup(config)
end

-- non-lsp-install servers
require("lspconfig").java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

require("deno-nvim").setup({
	server = {
		on_attach = function(client, bufnr)
			local active_clients = vim.lsp.get_active_clients()
			for _, running_client in pairs(active_clients) do
				if running_client.name == "tsserver" then
					client.stop()
				end
			end
			on_attach_format(client, bufnr)
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
		on_attach = function(client, buf_nr)
			inlay_hints.on_attach(client, buf_nr)
			on_attach_format(client, buf_nr)
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
	tools = {
		inlay_hints = {
			auto = false,
		},
	},
})

require("typescript").setup({
	server = {
		capabilities = capabilities,
		root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = function(client, bufnr)
			local active_clients = vim.lsp.get_active_clients()
			for _, running_client in pairs(active_clients) do
				if running_client.name == "denols" then
					client.stop()
				end
			end
			-- inlay_hints.on_attach(client, bufnr)
		end,
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},
})

inlay_hints.setup()

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
