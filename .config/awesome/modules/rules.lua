local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

local clientkeys = require("modules.keybind.client")
local clientbuttons = require("modules.keybind.button")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = 0, -- beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"Qalculate-gtk",
			},

			-- Name property matching (note: xprop can help you with these names)
			name = {
				"Event Tester", -- xev.
			},

			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g., Google Chrome's (detached) Developer Tools.
			},
		},

		properties = {
			floating = true,
			placement = awful.placement.centered,
			titlebars_enabled = false,
		},
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },
}

-- Set clients to always map on the specify tag

local array = { "firefox", "Spotify" }

for i = 1, #array do
	-- Add the rule dynamically for each application in the array
	table.insert(awful.rules.rules, {
		rule = { class = array[i] },
		properties = {
			screen = 1,
			tag = tostring(i + 1),
		},
	})
end
