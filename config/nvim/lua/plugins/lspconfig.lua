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

lspinstall.setup()

local function setup_servers()
  local servers = lspinstall.installed_servers()

  table.insert(servers, "erlangls")
  table.insert(servers, "ocamllsp")
  table.insert(servers, "java_language_server")

  for _, server in pairs(servers) do
    local config = { capabitilies = capabilities }

    if server == "elixir" then
      config.filtetypes = { "elixir", "leex", "heex", "eex" }
    elseif server == "java_language_server" then
      config.cmd = { "/home/alex/java-language-server/dist/lang_server_linux.sh" }
    elseif server == "python" then
      config.root_dir = function(fname)
        return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(
          fname
        ) or lspconfig.util.path.dirname(fname)
      end
    elseif server == "rust" then
      config.settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          --[[ cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true }, ]]
        },
      }
    elseif server == "typescript" then
      config.filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      }
    end

    lspconfig[server].setup(config)
  end
end

setup_servers()

require('lspinstall').post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end

vim.cmd([[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]])
