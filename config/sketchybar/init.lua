package.cpath = package.cpath .. ";/Users/" .. os.getenv("USER") .. "/.local/share/sketchybar_lua/?.so"

local sbar = require("sketchybar")

sbar.begin_config()

sbar.bar({
	position = "top",
	height = 30,
	blur_radius = 30,
	color = "0x4000000",
})

sbar.default({
	padding_left = 5,
	padding_right = 5,
	icon = {
		font = "Symbols Nerd Font Mono:Bold:17.0",
		color = "0xffffffff",
		padding_left = 4,
		padding_right = 4,
	},
	label = {
		font = "Berkeley Mono:Bold:14.0",
		color = "0xffffffff",
		padding_left = 4,
		padding_right = 4,
	},
})

local workspaces = {}
for i = 1, 10 do
	table.insert(
		workspaces,
		i,
		sbar.add("item", "workspace." .. tostring(i), {
			drawing = false,
		})
	)
end

sbar.add("item", "chevron", {
	icon = {
		string = "󰅂 ",
	},
	label = { drawing = false },
	position = "left",
})

local front_app = sbar.add("item", "front_app", {
	icon = { drawing = false },
	position = "left",
})

front_app:subscribe("front_app_switched", function(env)
	front_app:set({ label = { string = env.INFO } })
end)

sbar.add("event", "aerospace_workspace_change")

sbar.exec(
	"aerospace list-workspaces --monitor all --format '%{monitor-appkit-nsscreen-screens-id}|%{workspace}'",
	function(result, exit_code)
		if exit_code ~= 0 then
			return
		end

		for line in result:gmatch("[^\r\n]*") do
			for id, workspace in line:gmatch("(%d+)|(%d+)") do
				local item = workspaces[tonumber(workspace)]
				item:set({
					drawing = true,
					display = id,
					position = "left",
					label = workspace,
					background = {
						color = "0xfff5a97f",
						corner_radius = 5,
						height = 20,
						drawing = false,
					},
					click_script = "aerospace workspace " .. workspace,
				})
				item:subscribe("aerospace_workspace_change", function(env)
					if env.FOCUSED_WORKSPACE == workspace then
						item:set({
							background = { drawing = true },
						})
					else
						item:set({
							background = { drawing = false },
						})
					end
				end)
			end
		end
	end
)

local clock = sbar.add("item", "clock", {
	update_freq = 10,
	icon = { string = "󱑎 " },
	position = "right",
})

clock:subscribe({ "forced", "routine", "system_woke" }, function()
	clock:set({ label = os.date("%m/%d %I:%M %p") })
end)

local volume = sbar.add("item", "volume", { position = "right" })
volume:subscribe("volume_change", function(env)
	local level = tonumber(env.INFO)
	volume:set({ label = { string = env.INFO .. "%" } })
	if level >= 60 then
		volume:set({ icon = { string = "󰕾" } })
	elseif level >= 30 then
		volume:set({ icon = { string = "󰖀" } })
	elseif level >= 10 then
		volume:set({ icon = { string = "󰕿" } })
	else
		volume:set({ icon = { string = "󰖁" } })
	end
end)

local battery = sbar.add("item", "battery", {
	update_freq = 120,
	position = "right",
})

battery:subscribe({ "system_woke", "power_source_change" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local percentage = string.match(batt_info, "(%d+)%%")
		local charging = string.find(batt_info, "AC Power") ~= nil

		local icon
		if charging then
			icon = "󰂄"
		elseif percentage ~= nil then
			percentage = tonumber(percentage)
			if percentage >= 90 then
				icon = "󰁹"
			elseif percentage >= 60 then
				icon = "󰂁"
			elseif percentage >= 30 then
				icon = "󰁽"
			elseif percentage >= 10 then
				icon = "󰁺"
			else
				icon = "󰂎"
			end
		end
		battery:set({
			icon = { string = icon },
			label = { string = percentage and tostring(percentage) .. "%" or "" },
		})
	end)
end)

sbar.end_config()

sbar.event_loop()
