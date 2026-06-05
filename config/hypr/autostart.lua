-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

local programs = require("programs")

hl.on("hyprland.start", function()
	hl.exec_cmd(programs.launcher .. " server")
	hl.exec_cmd("steam", { workspace = "3" })
	hl.exec_cmd("signal-desktop", { workspace = "5" })
	hl.exec_cmd("firefox", { workspace = "1" })
	-- hl.exec_cmd("waybar")
	hl.exec_cmd("discord", { workspace = "4" })
	hl.exec_cmd(programs.terminal, { workspace = "2" })
	hl.exec_cmd("qs -c noctalia-shell")
end)
