-- vim.api.nvim_create_autocmd({ "TermOpen" }, {
-- 	callback = function()
-- 		vim.cmd([[
--        setlocal nonumber norelativenumber nocursorline winhl=Normal:NormalFloat
--        tnoremap <buffer> <Esc> <c-\><c-n>
--      ]])
-- 	end,
-- })

-- TODO:  do i care about supporting a custom path?
vim.api.nvim_create_user_command("Decaffeinate", function()
	-- local cmd = vim.o.shell .. " -l bazel run @decaffeinate//:run -- " .. vim.fn.expand("%:p")
	local cmd = "bazel run @decaffeinate//:run -- " .. vim.fn.expand("%:p")
	Snacks.terminal.open(cmd, {
		env = {
			PATH = os.getenv("PATH"),
		},
		interactive = false,
		win = {
			position = "right",
		},
	})
	--[[ require("terminal").run({
		"bazel",
		"run",
		"@decaffeinate//:run",
		"--",
		vim.fn.expand("%:p"),
	}, {
		layout = { open_cmd = "botright vertical new" },
	}) ]]
end, {})

local npm_install = function(args)
	if type(args) == "string" then
		args = vim.trim(args)
	end
	local package_info = vim.system({ "npm", "show", "--json", args }, { text = true }):wait(1000)
	local parsed = vim.json.decode(package_info.stdout)

	local tarball = vim.system({ "curl", "-s", parsed.dist.tarball }):wait()
	local sha_cmd = vim.system({ "sha256sum" }, { stdin = tarball.stdout, text = true }):wait()
	local head_cmd = vim.system({ "head", "-c", "64" }, { stdin = sha_cmd.stdout, text = true }):wait()
	local sha = head_cmd.stdout

	if sha == "" then
		vim.notify("Failed to obtain sha for " .. args, vim.log.levels.ERROR)
	end

	local install = 'npm_install(\n\tname = "'
		.. parsed.name
		.. '",\n\tversion = "'
		.. parsed.version
		.. '",\n\tsha256 = "'
		.. sha
		.. '"\n)'

	return install
end

vim.api.nvim_create_user_command("NpmInstall", function(command)
	local args = command.args
	if type(args) == "string" then
		args = vim.trim(args)
	end
	local install = npm_install(args)
	vim.fn.setreg("+", install)
end, { nargs = "*" })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.gleam" },
	callback = function()
		vim.cmd([[set formatoptions+=cro]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Wrap text and spell check for typing-focused filetypes",
	callback = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	desc = "Highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})
