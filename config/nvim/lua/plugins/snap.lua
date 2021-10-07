local snap = require("snap")

snap.maps({
	-- { "<c-p>", snap.config.file({ producer = "ripgrep.file" }) },
	{
		"<C-p>",
		function()
			snap.run({
				producer = snap.get("consumer.fzf")(snap.get("producer.ripgrep.file")),
				select = snap.get("select.file").select,
				multiselect = snap.get("select.file").multiselect,
				views = { snap.get("preview.file") },
			})
		end,
	},
	{
		"<leader>ag",
		function()
			snap.run({
				producer = snap.get("consumer.limit")(10000, snap.get("producer.ripgrep.vimgrep")),
				select = snap.get("select.vimgrep").select,
				multiselect = snap.get("select.vimgrep").multiselect,
				views = { snap.get("preview.vimgrep") },
			})
		end,
	},
})
