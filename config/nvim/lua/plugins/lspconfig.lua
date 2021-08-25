local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")

if not present1 then
    error("ain't no swang but an lsp thang")
    return
end

-- `cmp` stuff
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--[[ local crystalline_config = {
  cmd = { "crystalline" };
  filetypes = { "crystal" };
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end;
  root_patterns = { "shard.yml", ".git" };
} ]]

local erlang_config = {
    cmd = {"erlang_ls"},
    filetypes = {"erlang"},
    root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end,
    root_patterns = {"rebar.config", ".git"}
}

local elixirls_config = {cmd = {"elixir-ls"}, filetypes = {"elixir"}}

local javals_config = {
    cmd = {"/home/alex/java-language-server/dist/lang_server_linux.sh"},
    filetypes = {"java"},
    root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end
}

local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
local luals_config = {
    cmd = {"lua-language-server", "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            filetypes = {"lua"},
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

lspconfig.pyright.setup({
    root_dir = function(fname)
        return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg",
                                           "pyproject.toml", "requirements.txt")(
                   fname) or lspconfig.util.path.dirname(fname)
    end
})

-- https://rust-analyzer.github.io/manual.html#installation
lspconfig.rust_analyzer.setup({
    settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}
})

-- npm i -g typescript-language-server
lspconfig.tsserver.setup({
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    }
})

lspconfig.ocamllsp.setup({})

local elixir = {formatCommand = "mix format -", formatStdin = true}
local elm = {formatCommand = "elm-format -", formatStdin = true}
local go = {formatCommand = "gofmt", formatStdin = true}
local python = {formatCommand = "yapf --quiet", formatStdin = true}
local prettier = {
    formatCommand = "prettier --stdin-filepath ${INPUT}",
    formatStdin = true
}
local lua = {formatCommand = "lua-format -i", formatStdin = true}
local rust = {formatCommand = "rustfmt", formatStdin = true}

local languages = {
    elixir = {elixir},
    elm = {elm},
    go = {go},
    lua = {lua},
    python = {python},
    rust = {rust},
    javascript = {prettier},
    javascriptreact = {prettier},
    typescript = {prettier},
    typescriptreact = {prettier}
}

lspconfig.efm.setup({
    init_options = {documentFormatting = true},
    filetypes = vim.tbl_keys(languages),
    settings = {rootMarkers = {".git/"}, languages = languages}
})

local function setup_servers()
    if not present2 then error("ugh, couldn't find lspinstall") end
    lspinstall.setup()

    local configs = require 'lspconfig/configs'

    local servers = lspinstall.installed_servers()
    -- table.insert(servers, "crystalline")
    table.insert(servers, "erlang")
    table.insert(servers, "java")

    for _, server in pairs(servers) do
        Config = {}
        --[[ if server == "crystalline" then
      Config = crystalline_config;
      configs.crystalline = {
        default_config = crystalline_config
      }
     end ]]
        if server == "erlang" then
            Config = erlang_config;
            configs.erlang = {default_config = erlang_config}
        end
        if server == "elixirls" then Config = elixirls_config end
        if server == "java" then
            configs.java = {default_config = javals_config}
        end
        if server == "lua" then Config = luals_config end

        --[[ local coq = require('coq')()
    local config = coq.lsp_ensure_capabilities(Config) ]]
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

vim.cmd [[
  augroup lsp
    autocmd!
    autocmd FileType scala,sbt lua require("metals").initialize_or_attach(METALS_CONFIG)
  augroup end
]]
