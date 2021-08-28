local pears = require('pears')
local cmp = require('cmp')

pears.setup(function(conf)
    conf.preset("tag_matching", {
        filetypes = {
            "javascript", "typescript", "javascriptreact", "typescriptreact",
            "php", "jsx", "tsx", "html", "xml", "markdown", "eruby", "eelixir",
            "heex", "leex"
        }
    })
    conf.preset("html")
    conf.on_enter(function(pears_handle)
        if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
            return cmp.mapping.complete()
        else
            pears_handle()
        end
    end)
end)