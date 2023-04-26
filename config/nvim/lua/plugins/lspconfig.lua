local configs = require("lspconfig.configs")
local lspconfig = require("lspconfig")
local null = require("null-ls")
local path = require("mason-core.path")
local wk = require("which-key")

-- when in a deno project, we need to disable tsserver single_file_support
lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
  local cwd = vim.loop.cwd()
  if config.name == "tsserver" and vim.fn.filereadable(cwd .. "/deno.jsonc") == 1 then
    config.single_file_support = false
  end
end)

local mason_data_path = path.concat({ vim.fn.stdpath("data"), "mason", "bin" })

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_configs = {
  clangd = {
    capabilities = capabilities,
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
  },
  gopls = {
    capabilities = capabilities,
    settings = {
      gopls = {
        env = {
          GOPACKAGESDRIVER = "/home/alex/bin/gopackagesdriver",
        },
        directoryFilters = {
          "-bazel-bin",
          "-bazel-out",
          "-bazel-testlogs",
          "-bazel-vistar",
          "-bazel-app",
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
    on_attach = function(client)
      require("virtualtypes").on_attach(client)
    end,
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
  rust_analyzer = {
    capabilities = capabilities,
    on_attach = function(client)
      require("virtualtypes").on_attach(client)
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
  sorbet = {
    capabilities = capabilities,
  },
  sqlls = {
    capabilities = capabilities,
  },
  tsserver = {
    capabilities = capabilities,
    root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
    init_options = require("nvim-lsp-ts-utils").init_options,
    flags = {
      debounce_text_changes = 150,
    },
    on_attach = function(client)
      local active_clients = vim.lsp.get_active_clients()
      for _, running_client in pairs(active_clients) do
        if running_client.name == "denols" then
          client.stop()
        end
      end
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({})
      ts_utils.setup_client(client)
    end,
    commands = {
      OrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
          })
        end,
        description = "Organize Imports",
      },
    },
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

local on_attach_format = function(client, bufnr)
  vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

local helpers = require("null-ls.helpers")
local pyfmt = {
  method = null.methods.FORMATTING,
  filetypes = { "python" },
  generator = helpers.formatter_factory({
    args = { "run", "//tools/pyfmt" },
    command = "bazel",
    to_stdin = true,
  }),
}
local java_format = {
  method = null.methods.FORMATTING,
  filetypes = { "java" },
  generator = helpers.formatter_factory({
    args = { "run", "//tools/java-format", "--", "--stdin" },
    command = "bazel",
    to_stdin = true,
  }),
}

-- TODO:
--  pyfmt and java custom
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

    null.builtins.formatting.buildifier.with({
      command = path.concat({ mason_data_path, "buildifier" }),
    }),
    null.builtins.formatting.fish_indent,
    null.builtins.formatting.jq,
    null.builtins.formatting.just,
    null.builtins.formatting.prettier.with({
      command = path.concat({ mason_data_path, "prettier" }),
    }),
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
    if
        not vim.tbl_contains({ "tsserver", "lua_ls", "pyright" }, client.name)
        and client.supports_method("textDocument/formatting")
    then
      on_attach_format(client, bufnr)
      wk.register({
        ["<leader>F"] = {
          function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
          "LSP Format",
        },
      })
    end
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
      if client.supports_method("textDocument/formatting") then
        on_attach_format(client, bufnr)
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

if not configs.gleam then
  configs.gleam = {
    default_config = {
      cmd = { "gleam", "lsp" },
      filetypes = { "gleam" },
      on_attach = function(client, bufnr)
        client.server_capabilities.completionProvider = false
        on_attach_format(client, bufnr)
      end,
      root_dir = function()
        return vim.fn.getcwd()
      end,
    },
  }
end
require("lspconfig").gleam.setup({})

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
