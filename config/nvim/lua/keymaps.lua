local has = require("utils").has
local wk = require("which-key")

-- better up/down??? maybe
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

wk.add({
	-- quit
	{ "<leader>qq", ":qa<cr>", desc = "Quit and close all" },
	-- inspect
	{ "<leader>is", "<cmd>Inspect<cr>", desc = "Display highlight information" },
	-- visual copy persist cursor location
	{
		mode = { "v" },
		{ "y", "ygv<esc>", desc = "Copy block and keep cursor location" },
	},
	{ "H", "^", desc = "Start of line" },
	{ "L", "$", desc = "End of line" },
	{ "<c-d>", "<c-d>zz", desc = "down and center" },
	{ "<c-f>", "<c-f>zz", desc = "down more and center" },
	{ "<c-u>", "<c-u>zz", desc = "up and center" },
	{
		mode = { "v" },
		{ "<leader>rs", ":sort<cr>", desc = "Sort visual items" },
	},
	-- LSP
	{
		"<leader>j",
		function()
			if has("0.11") then
				vim.diagnostic.jump({ count = 1, float = true })
			else
				vim.diagnostic.goto_next({ float = true })
			end
		end,
		desc = "Next LSP diagnostic",
	},
	{
		"<leader>k",
		function()
			if has("0.11") then
				vim.diagnostic.jump({ count = -1, float = true })
			else
				vim.diagnostic.goto_next({ float = true })
			end
		end,
		desc = "Prev LSP diagnostic",
	},
	{
		"<leader>h",
		"<cmd>cprev<cr>",
		desc = "Previous quickfix item",
	},
	{
		"<leader>l",
		"<cmd>cnext<cr>",
		desc = "Next quickfix item",
	},
	{ "<leader>ls", "<cmd>LspRestart<cr>", desc = "Restart LSP server(s)" },
	{
		"<leader>ih",
		function()
			-- TODO:  check if any client(s) support it
			-- if client.supports_method("textDocument/inlayHint") then
			local current_buf = vim.api.nvim_get_current_buf()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = current_buf })
			if require("utils").has("0.10.0") then
				vim.lsp.inlay_hint.enable(not enabled, { bufnr = current_buf })
			else
				vim.lsp.inlay_hint.enable(current_buf, not enabled)
			end
			-- end
		end,
		desc = "Toggle inlay hints",
	},
	{
		"K",
		function()
			vim.lsp.buf.hover()
		end,
		desc = "LSP hover",
	},
	{
		"<leader>ca",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code Actions",
	},
	{
		"<leader>rn",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "LSP rename",
	},
	{
		mode = { "v" },
		{
			"<leader>ca",
			function()
				local start = vim.api.nvim_buf_get_mark(0, "<")
				local ending = vim.api.nvim_buf_get_mark(0, ">")
				vim.lsp.buf.code_action({
					range = {
						start = start,
						["end"] = ending,
					},
				})
			end,
			desc = "Range Code Actions",
		},
	},
	{ "<C-k>", vim.lsp.buf.signature_help, desc = "Display signature help" },

	-- close buffers
	{
		"<leader>bc",
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
		desc = "Close all buffers but current",
	},
	-- swap windows
	{ "<leader>pw", require("utils").swap_windows, desc = "Swap buffer between current and other window" },

	{
		"<leader>z",
		group = "lazy",
	},
	{ "<leader>zs", "<cmd>Lazy sync<cr>", desc = "Lazy sync" },
	{ "<leader>zi", "<cmd>Lazy<cr>", desc = "Lazy install" },
	{ "<leader>zo", "<cmd>Lazy home<cr>", desc = "Lazy open" },

	{
		"<leader>yp",
		function()
			vim.fn.setreg("+", vim.fn.expand("%:p:.:h"))
		end,
		desc = "Copy relative directory to clipboard",
	},
})
