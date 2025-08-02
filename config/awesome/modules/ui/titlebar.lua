local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local function create_mac_button(c, color_focus, color_unfocus, shp)
	local tb = wibox.widget({
		forced_width = dpi(20),
		forced_height = dpi(20),

		bg = color_focus .. 90,
		shape = shp,
		border_color = beautiful.border_color,
		widget = wibox.container.background,
	})

	local function update()
		if client.focus == c then
			tb.bg = color_focus
		else
			tb.bg = color_unfocus
		end
	end
	update()

	c:connect_signal("focus", update)
	c:connect_signal("unfocus", update)

	tb:connect_signal("mouse:enter", function()
		tb.bg = color_focus .. 55
	end)
	tb:connect_signal("mouse:leave", function()
		tb.bg = color_focus
	end)

	tb.visible = true
	return tb
end

local helper = function(tl, tr, br, bl, rate)
	return function(cr, width, height)
		gears.shape.partial_squircle(cr, width, height, tl, tr, br, bl, rate, delta)
	end
end

local function set_mac_titlebar(c)
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			if c.maximized == true then
				c.maximized = false
			end
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	local ci = function(width, height)
		return function(cr)
			gears.shape.circle(cr, width, height)
		end
	end

	local close = create_mac_button(c, "#FF6057", beautiful.titlebar_unfocus, ci(dpi(11), dpi(11)))
	close:connect_signal("button:press", function()
		c:kill()
	end)

	local wrap_widget = function(w)
		return { w, top = dpi(20), widget = wibox.container.margin }
	end

	awful.titlebar(c, { position = "top", size = dpi(30), bg = "#00000000" }):setup({
		{ -- left
			wrap_widget({ close, left = dpi(25), widget = wibox.container.margin }),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- middle
			awful.titlebar.widget.iconwidget(c),
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- right
			layout = wibox.layout.fixed.horizontal,
		},
		bg = beautiful.bg,
		shape = helper(beautiful.border_radius, true, true, false, false),
		widget = wibox.container.background,
	})

	c.border_width = 0
	c.border_color = beautiful.border_color or "#333333"

	local titlebar_widget = awful.titlebar.widget.titlewidget(c)
	titlebar_widget.align = "center"
end

client.connect_signal("request::titlebars", set_mac_titlebar)
