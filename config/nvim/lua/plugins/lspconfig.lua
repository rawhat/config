local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")

if not present1 then
	error("failed to load `lspconfig`")
	return
end

if not present2 then
  error("failed to load `lspinstall`")
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local language_config = {
  erlangls = {},
  ocamllsp = {},
  zls = {},

	elixirls = {
		cmd = { "elixir-ls" },
		filetypes = { "elixir", "leex", "heex", "eex" },
	},
	java_language_server = {
		cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
	},
	pyright = {
		root_dir = function(fname)
			return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
				fname
			) or lspconfig.util.path.dirname(fname)
		end,
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
				--[[ cargo = { loadOutDirsFromCheck = true },
			procMacro = { enable = true }, ]]
			},
		},
	},
	tsserver = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},
	sumneko_lua = {
		cmd = {
			"lua-language-server",
			"-E",
			vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server/main.lua",
		},
		settings = {
			Lua = {
				filetypes = { "lua" },
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = { enable = false },
			},
		},
	},
}

lspinstall.setup()

for server, config in pairs(language_config) do
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end

vim.cmd([[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]])
