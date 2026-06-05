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
