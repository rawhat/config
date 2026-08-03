local function patch_flash_searchstate()
	local Hacks = require("flash.hacks") -- triggers flash's own ffi.cdef of the old symbols
	local ffi = require("ffi")

	-- Old standalone symbol still resolvable? then leave flash's own hacks alone.
	if pcall(function()
		return ffi.C.search_match_lines
	end) then
		return
	end

	-- New: SearchState struct (src/nvim/search_defs.h), exported global `Search`.
	pcall(
		ffi.cdef,
		[[
      typedef struct {
        bool    hl_match;
        int32_t match_lines;
        int     match_endcol;
        int32_t first_line;
        int32_t last_line;
        bool    no_smartcase;
        int     cmdlen;
        bool    no_hlsearch;
      } SearchState;
      SearchState Search;
    ]]
	)

	-- Struct not resolvable? leave flash as-is (don't make it worse).
	if not pcall(function()
		return ffi.C.Search.match_lines
	end) then
		return
	end

	local C = ffi.C
	local Pos = require("flash.search.pos")
	local incsearch_state = {}

	function Hacks.get_end_pos(from)
		local ret = Pos({
			from[1] + C.Search.match_lines,
			math.max(0, C.Search.match_endcol - 1),
		})
		local line = vim.api.nvim_buf_get_lines(0, ret[1] - 1, ret[1], false)[1]
		local char_idx = vim.fn.charidx(line, ret[2])
		ret[2] = vim.fn.byteidx(line, char_idx)
		return ret
	end

	function Hacks.save_incsearch_state()
		incsearch_state = {
			match_endcol = C.Search.match_endcol,
			match_lines = C.Search.match_lines,
		}
	end

	function Hacks.restore_incsearch_state()
		C.Search.match_endcol = incsearch_state.match_endcol
		C.Search.match_lines = incsearch_state.match_lines
	end
end

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<cr>",
			mode = { "n", "x", "o" },
			desc = "jump around",
			function()
				require("flash").jump()
			end,
		},
		{
			"S",
			mode = { "n", "o", "x" },
			desc = "leapin around the trees",
			function()
				require("flash").treesitter()
			end,
		},
	},
	setup = function()
		patch_flash_searchstate()
		require("flash").setup({})
	end,
}
