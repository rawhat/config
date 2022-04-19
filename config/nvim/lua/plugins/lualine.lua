-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = require('nightfox.palette').load("duskfox")

local gps = require("nvim-gps")

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = "",
		section_separators = "",
		-- theme = "auto",
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg0, bg = colors.bg0 } },
			inactive = { c = { fg = colors.fg0, bg = colors.bg0 } },
		},
		globalstatus = true,
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_v = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue.base }, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	-- mode component
	function()
		-- auto change color according to neovims mode
		local mode_color = {
			n = colors.red.base,
			i = colors.green.base,
			v = colors.blue.base,
			[""] = colors.blue.base,
			V = colors.blue.base,
			c = colors.magenta.base,
			no = colors.red.base,
			s = colors.orange.base,
			S = colors.orange.base,
			[""] = colors.orange.base,
			ic = colors.yellow.base,
			R = colors.pink.base,
			Rv = colors.pink.base,
			cv = colors.red.base,
			ce = colors.red.base,
			r = colors.cyan.base,
			rm = colors.cyan.base,
			["r?"] = colors.cyan.base,
			["!"] = colors.red.base,
			t = colors.red.base,
		}
		vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg0)
		return ""
	end,
	color = "LualineMode",
	padding = { right = 1 },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	path = 1,
	color = { fg = colors.magenta.base, gui = "bold" },
})

ins_left({ "location" })

ins_left({ "progress", color = { fg = colors.fg0, gui = "bold" } })

ins_left({
	"diagnostics",
	sources = { "nvim_lsp" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red.base },
		color_warn = { fg = colors.yellow.base },
		color_info = { fg = colors.cyan.base },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
-- ins_left({
-- 	function()
-- 		return "%="
-- 	end,
-- })

ins_left({
	function()
		if gps.is_available() then
			return gps.get_location()
		end
		return ""
	end,
	color = { fg = colors.fg0, gui = "bold" },
})

-- ins_left({
ins_right({
	-- Lsp server name .
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return client.name
			end
		end
		return msg
	end,
	icon = " LSP:",
	color = { fg = "#ffffff", gui = "bold" },
})

-- Add components to right sections
-- ins_right({
-- 	"o:encoding", -- option component same as &encoding in viml
-- 	fmt = string.upper, -- I'm not sure why it's upper case either ;)
-- 	cond = conditions.hide_in_width,
-- 	color = { fg = colors.green.base, gui = "bold" },
-- })

-- ins_right({
-- 	"fileformat",
-- 	fmt = string.upper,
-- 	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
-- 	color = { fg = colors.green.base, gui = "bold" },
-- })

ins_right({
	"branch",
	icon = "",
	color = { fg = colors.pink.base, gui = "bold" },
})

ins_right({
	"diff",
	-- Is it me or the symbol for modified us really weird
	symbols = { added = " ", modified = "柳", removed = " " },
	diff_color = {
		added = { fg = colors.green.base },
		modified = { fg = colors.orange.base },
		removed = { fg = colors.red.base },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue.base },
	padding = { left = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)
