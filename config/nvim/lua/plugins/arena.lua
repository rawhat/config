return {
	"dzfrias/arena.nvim",
	event = "BufWinEnter",
	config = function()
		require("arena").setup({
			devicons = true,
			max_items = 10,
			ignore_current = true,
			always_context = { "index.ts", "index.tsx", "index.js", "index.jsx", "mod.rs", "init.lua", "BUILD" },
		})
	end,
	keys = {
		{ "<leader>f", "<cmd>ArenaOpen<cr>", desc = "Open the arena" },
	},
}
