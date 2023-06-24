local M = {}

local notify = require("notify")

M.gitiles = function()
	local cwd = vim.uv.cwd()
	if cwd:find("^/home/alex/vistar/vistar") ~= nil then
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local file = vim.api.nvim_buf_get_name(0)
		local relative_path = string.gsub(file, vim.uv.cwd(), "")

		local gitiles_url = "https://gerrit.vistarmedia.com/plugins/gitiles/vistar/+/refs/heads/develop"

		local with_row = gitiles_url .. relative_path .. "#" .. row

		require("osc52").copy(with_row)
		notify("Gitiles URL copied to clipboard\n\n" .. with_row, "info")
	else
		notify("Can only be called from vistar root", "error")
	end
end

return M
