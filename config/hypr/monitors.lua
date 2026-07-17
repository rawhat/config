-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "DP-3",
	mode = "2560x1440@359.98",
	position = "0x0",
	scale = 1,
	vrr = 3,
	-- bitdepth = 10,
	-- cm = "hdr",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@100",
	position = "auto-left",
	scale = 1,
	-- vrr = 2,
})

hl.workspace_rule({
	workspace = "1",
	monitor = "DP-3",
	default = true,
	persistent = true,
})

hl.workspace_rule({
	workspace = "2",
	monitor = "DP-3",
	persistent = true,
})

hl.workspace_rule({
	workspace = "3",
	monitor = "DP-3",
	persistent = true,
})

hl.workspace_rule({
	workspace = "gaming",
	monitor = "DP-3",
	persistent = true,
})

hl.workspace_rule({
	workspace = "4",
	monitor = "HDMI-A-1",
	default = true,
	persistent = true,
})

hl.workspace_rule({
	workspace = "5",
	monitor = "HDMI-A-1",
	persistent = true,
})
