local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lsp_installer.on_server_ready(function(server)
	local config = { capabilities = capabilities }

	if server.name == "elixirls" then
		config.filtetypes = { "elixir", "leex", "heex", "eex" }
	elseif server.name == "pyright" then
		config.root_dir = function(fname)
			return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
				fname
			) or lspconfig.util.path.dirname(fname)
		end
	elseif server.name == "rust_analyzer" then
		config.on_attach = require("virtualtypes").on_attach
		config.settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
			},
		}
	elseif server.name == "tsserver" then
		config.filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		}
	elseif server.name == "ocamlls" then
		config.on_attach = require("virtualtypes").on_attach
	end

	server:setup(config)
end)

-- non-lsp-install servers
lspconfig.java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

vim.cmd([[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]])
