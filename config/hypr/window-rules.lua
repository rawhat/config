-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(false)

-- hl.window_rule({
-- 	name = "steam-games",
-- 	match = { class = "^(steam_app_)(.*)$" },
-- 	tag = "+game",
-- })
--
-- hl.window_rule({
-- 	name = "fullscreen-games",
-- 	match = { fullscreen = true },
-- 	tag = "+game",
-- })
--
-- hl.window_rule({
-- 	name = "xwayland",
-- 	match = { xwayland = true },
-- 	tag = "+game",
-- })
--
-- hl.window_rule({
-- 	name = "game-content",
-- 	match = { tag = "game" },
-- 	content = "game",
-- 	fullscreen = true,
-- 	immediate = true,
-- })

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

local gamingApps = "^(steam_app.*|gamescope)$"
local gamingWorkspace = "name:gaming"

hl.window_rule({ match = { content = "game" }, workspace = gamingWorkspace })
hl.window_rule({ match = { class = gamingApps }, workspace = gamingWorkspace })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" }, float = true })
hl.window_rule({
	match = {
		class = "^(steam)$",
		title = "^(Launching\\.{3})$",
	},
	float = true,
	center = true,
	workspace = gamingWorkspace,
})
hl.window_rule({
	match = {
		class = gamingApps,
		title = "^(.+)$",
		initial_title = "negative:^(.*\\\\home\\\\.*)$",
	},
	size = "monitor_w monitor_h",
	fullscreen_state = 2,
	content = "game",
})
hl.window_rule({
	match = {
		class = "^(steam_app.*)$",
		initial_title = "^$",
	},
	float = true,
	center = true,
	fullscreen = false,
	fullscreen_state = 0,
})
