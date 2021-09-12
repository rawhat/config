local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")

if not present1 then
	error("ain't no swang but an lsp thang")
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local elixirls_config = { cmd = { "elixir-ls" }, filetypes = { "elixir" } }

lspconfig.erlangls.setup({})

lspconfig.java_language_server.setup({
	cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" },
})

local sumneko_root_path = vim.fn.stdpath("cache") .. "/lspconfig/sumneko_lua/lua-language-server"
local luals_config = {
	cmd = { "lua-language-server", "-E", sumneko_root_path .. "/main.lua" },
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
}

lspconfig.pyright.setup({
	root_dir = function(fname)
		return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
			or lspconfig.util.path.dirname(fname)
	end,
})

-- https://rust-analyzer.github.io/manual.html#installation
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			checkOnSave = { command = "clippy" },
			--[[ cargo = { loadOutDirsFromCheck = true },
			procMacro = { enable = true }, ]]
		},
	},
})

-- npm i -g typescript-language-server
lspconfig.tsserver.setup({
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
})

lspconfig.ocamllsp.setup({})

lspconfig.zls.setup({})

local function setup_servers()
	if not present2 then
		error("ugh, couldn't find lspinstall")
	end
	lspinstall.setup()

	local servers = lspinstall.installed_servers()

	for _, server in pairs(servers) do
		Config = {}
		if server == "elixirls" then
			Config = elixirls_config
		end
		if server == "lua" then
			Config = luals_config
		end

		local config = Config
		config.capabilities = capabilities
		lspconfig[server].setup(config)
	end
end

setup_servers()

lspinstall.post_install_hook = function()
	setup_servers()
	vim.cmd("bufdo e")
end

vim.cmd([[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]])
