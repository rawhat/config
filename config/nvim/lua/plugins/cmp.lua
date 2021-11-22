local has_cmp, cmp = pcall(require, "cmp")
local has_lspkind, lspkind = pcall(require, "lspkind")
local has_luasnip, luasnip = pcall(require, "luasnip")

if not has_cmp then
	error("`cmp` not loaded")
end
if not has_lspkind then
	error("`lspkind` not loaded")
end
if not has_luasnip then
	error("`luasnip` not loaded")
end

vim.opt.completeopt:remove({ "longest" })

local term = function(cmd)
	vim.api.nvim_replace_termcodes(cmd, true, true, true)
end

local feedkey = function(key)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "", true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = {
		-- NOTE:  Not mapping <CR> here since `autopairs` covers that already
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jump() then
				term("<Plug>luasnip-expand-or-jump")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				feedkey("<Plug>luasnip-jump-prev")
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<CR>"] = cmp.mapping.confirm(),
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "luasnip" },
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
			})[entry.source.name]
			return vim_item
		end,
	},
})
