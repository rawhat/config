do
	local FSWATCH_EVENTS = {
		Created = 1,
		Updated = 2,
		Removed = 3,
		-- Renamed
		OwnerModified = 2,
		AttributeModified = 2,
		MovedFrom = 1,
		MovedTo = 3,
		-- IsFile
		IsDir = false,
		IsSymLink = false,
		PlatformSpecific = false,
		-- Link
		-- Overflow
	}

	--- @param data string
	--- @param opts table
	--- @param callback fun(path: string, event: integer)
	local function fswatch_output_handler(data, opts, callback)
		local d = vim.split(data, "%s+")
		local cpath = d[1]

		for i = 2, #d do
			if FSWATCH_EVENTS[d[i]] == false then
				return
			end
		end

		if opts.include_pattern and opts.include_pattern:match(cpath) == nil then
			return
		end

		if opts.exclude_pattern and opts.exclude_pattern:match(cpath) ~= nil then
			return
		end

		for i = 2, #d do
			local e = FSWATCH_EVENTS[d[i]]
			if e then
				callback(cpath, e)
			end
		end
	end

	local function fswatch(path, opts, callback)
		local obj = vim.system({
			"fswatch",
			"--recursive",
			"--event-flags",
			"--exclude",
			"/.git/",
			path,
		}, {
			stdout = function(err, data)
				if err then
					error(err)
				end

				if not data then
					return
				end

				for line in vim.gsplit(data, "\n", { plain = true, trimempty = true }) do
					fswatch_output_handler(line, opts, callback)
				end
			end,
		})

		return function()
			obj:kill(2)
		end
	end

	if vim.fn.executable("fswatch") == 1 then
		print("okay we doin it")
		require("vim.lsp._watchfiles")._watchfunc = fswatch
	end
end
