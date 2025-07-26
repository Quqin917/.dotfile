-- luacheck: root

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local myMenu = require("modules.menu")

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		myMenu.mainMenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}
