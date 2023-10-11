local register = require("which-key").register

-- better up/down??? maybe
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- gimme the relative path
register({ ["<leader>bp"] = { "<cmd>echo %@<cr>", "Show relative path to buffer file" } })

-- gimme the gitiles link for a vistar file at the current line
register({
	["<leader>gt"] = {
		function()
			require("utils").gitiles()
		end,
		"Gitiles link to current line",
	},
})

-- delete that buffer
register({
	["<leader>bd"] = { ":bd!<cr>", "Delete buffer (press enter)" },
})

-- quit
register({
	["<leader>qq"] = { ":qa<cr>", "Quit and close all" },
})

-- inspect
register({
	["<leader>is"] = { "<cmd>Inspect<cr>", "Display highlight information" },
})

-- visual copy persist cursor location
register({
	y = { "ygv<esc>", "Copy block and keep cursor location" },
}, { mode = { "v" } })

register({
	H = { "^", "Start of line" },
	L = { "$", "End of line" },
})

register({
	["<c-d>"] = { "<c-d>zz", "down and center" },
	["<c-u>"] = { "<c-u>zz", "up and center" },
})

-- quickfix
register({
	q = {
		o = {
			":copen<cr>",
			"Open quickfix",
		},
		c = {
			":cclose<cr>",
			"Close quickfix",
		},
	},
}, { prefix = "<leader>", noremap = true, silent = true })

register({
	["<leader>s"] = {
		":sort<cr>",
		"Sort visual items",
	},
}, { mode = { "v" } })

-- LSP
register({
	name = "LSP",
	j = {
		function()
			vim.diagnostic.goto_next()
		end,
		"Next LSP diagnostic",
	},
	k = {
		function()
			vim.diagnostic.goto_prev()
		end,
		"Prev LSP diagnostic",
	},
	ls = {
		"<cmd>LspRestart<cr>",
		"Restart LSP server(s)",
	},
	ih = {
		function()
			-- TODO:  check if any client(s) support it
			-- if client.supports_method("textDocument/inlayHint") then
			local current_buf = vim.api.nvim_get_current_buf()
			vim.lsp.inlay_hint(current_buf, nil)
		end,
		"Toggle inlay hints",
	},
}, { prefix = "<leader>" })
register({
	name = "LSP",
	K = {
		function()
			vim.lsp.buf.hover()
		end,
		"LSP hover",
	},
})
register({
	name = "LSP",
	["<leader>ca"] = {
		function()
			vim.lsp.buf.code_action()
		end,
		"Code Actions",
	},
})
register({
	name = "LSP",
	["<leader>ca"] = {
		function()
			local start = vim.api.nvim_buf_get_mark(0, "<")
			local ending = vim.api.nvim_buf_get_mark(0, ">")
			vim.lsp.buf.code_action(nil, start, ending)
		end,
		"Range Code Actions",
	},
}, { mode = "v" })

-- close buffers
register({
	["<leader>bc"] = {
		function()
			local buffers = vim.api.nvim_list_bufs()
			local current_buf = vim.api.nvim_get_current_buf()
			for _, buffer_number in pairs(buffers) do
				local listed = vim.fn.buflisted(buffer_number)
				if listed == 1 and buffer_number ~= current_buf then
					vim.cmd.bd(buffer_number)
				end
			end
		end,
		"Close all buffers but current",
	},
})

register({
	name = "Lazy",
	z = {
		s = {
			"<cmd>Lazy sync<cr>",
			"Lazy sync",
		},
		i = {
			"<cmd>Lazy<cr>",
			"Lazy install",
		},
		o = {
			"<cmd>Lazy home<cr>",
			"Lazy open",
		},
	},
}, { prefix = "<leader>" })
