-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local hotkeys_popup = require("awful.hotkeys_popup")

local naughty = require("naughty")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local myMenu = require("modules.menu")

local terminal = "kitty"

-- Default modkey.
local modkey = "Mod4"

-- {{{ Key bindings
local globalkeys = gears.table.join(
	-- show help
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- Navigate between windows
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "navigation" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "navigation" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "navigation" }),

	-- Navigate between application inside windows
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- Show menu
	awful.key({ modkey }, "w", function()
		myMenu.mainMenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Manipulate application position
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),

	-- Manipulate cursor focus
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),

	-- Jump cursor to application with urgent state
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	-- Goes to the previous application
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	awful.key({ modkey }, "#107", function()
		awful.spawn("flameshot gui")
	end, { description = "Screenshot", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "q", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),

	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),

	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	-- Prompt
	awful.key({ modkey, "Shift" }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({}, "#148", function()
		awful.spawn("qalculate-gtk")
	end, { description = "open calculator", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),

	-- Menubar
	awful.key({ modkey }, "p", function()
		awful.spawn("rofi -show drun")
	end, { description = "show the menubar", group = "launcher" }),

	-- Volume
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.util.spawn("pamixer --decrease 5")
		awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
			local volume = stdout:gsub("\n", "")
			naughty.notify({ title = "Volume Down", text = volume .. "%", timeout = 1 })
		end)
	end, { description = "Decrease volume", group = "volume" }),

	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.util.spawn("pamixer --increase 5")
		awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
			local volume = stdout:gsub("\n", "")
			naughty.notify({ title = "Volume Increase", text = volume .. "%", timeout = 1 })
		end)
	end, { description = "Increase volume", group = "volume" }),

	awful.key({}, "XF86AudioMute", function()
		awful.util.spawn("pamixer --toggle-mute")
		awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
			naughty.notify({ title = "Volume Muted", timeout = 1 })
		end)
	end, { description = "Mute volume", group = "volume" })
)

-- {{{ Mouse bindings
require("modules.keybind.mouse")
-- }}}

local tagsKey = require("modules.keybind.tags")

root.keys(gears.table.join(globalkeys, tagsKey))
