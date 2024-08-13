return {
	--[[ "altermo/ultimate-autopair.nvim",
	-- branch = "v0.6",
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
		require("ultimate-autopair").init({
			require("ultimate-autopair").extend_default({}),
			{ profile = require("ultimate-autopair.experimental.cmpair").init },
		})
	end, ]]
}
