local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local alttab = require("awesome-switcher-preview")

module("keybinding")

local modkey = "Mod4"
local terminal = "urxvt"
local altkey = "Mod1"

-- short cut assignement for standard programs
local launcher_keys = awful.util.table.join(
    awful.key(
        { modkey }, "t", 
        function () 
            awful.spawn(terminal) 
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        { modkey }, "b",
        function () 
            awful.spawn("chromium") 
        end,
        {description = "start browser", group = "launcher"}
    ),
    awful.key(
        { modkey }, "p",
        function () 
            awful.spawn("evince") 
        end,
        {description = "start pdf reader", group = "launcher"}
    ),
    awful.key(
        { modkey }, "r",
        function () 
            awful.screen.focused().mypromptbox:run() 
        end,
        {description = "run prompt", group = "launcher"}
    )
)

-- keybinding for various utility functions
-- e.g. toggle conky, print screen, window lock
local util_keys = awful.util.table.join( 
    awful.key(
        { modkey }, "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),
    awful.key(
        { modkey }, "c",
        function ()
            awful.spawn(terminal)
        end,
        {description="toggle conky HUD", group="awesome"}
    ),
    awful.key(
        { modkey }, "d",
        function ()
            awful.spawn(terminal)
        end,
        {description="minimize all windows", group="awesome"}
    ),
    awful.key(
        { modkey }, "l",
        function()
            awful.spawn("slock")
        end,
        {description="lock the screen", group="awesome"}
    ),
    awful.key(
        { }, "Print",
        function()
           awful.spawn("scrot -u 'screenshot_%y%m%d_%T.png'")
        end,
        {description="take selective screentshot", group="awesome"}
    ),
    -- Volume handling
    awful.key(
        { } , "XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer set Master 9%+")
        end,
        {description="increase the volume by 9%", group="awesome"}
    ),
    awful.key(
        { } , "XF86AudioLowerVolume",
        function()
            awful.spawn("amixer set Master 9%-")
        end,
        {description="decrease the volume by 9%", group="awesome"}
    ),
    awful.key(
        { } , "XF86AudioMute",
        function()
            awful.spawn("amixer set Master toggle")
        end,
        {description="toggles the volume on or off", group="awesome"}
    ),
    -- Brightness handling
    awful.key(
        { } , "XF86MonBrightnessDown",
        function()
            awful.spawn("xbacklight -dec 15")
        end,
        {description="decreases the background light by 15%", group="awesome"}
    ),
    awful.key(
        { } , "XF86MonBrightnessUp",
        function()
            awful.spawn("xbacklight -inc 15")
        end,
        {description="increases the background light by 15%", group="awesome"}
    ),
    --[[
    awful.key(
        { modkey,"Shift", "Control" }, "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key(
        { modkey, "Shift"   }, "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    --]]
    -- swap clients
    awful.key({ altkey, }, "Tab",
        function ()
            alttab.switch(1, "Alt_L", "Tab", "ISO_Left_Tab")
        end,
        {description = "switch clients", group = "awesome"}
    ), 
    awful.key({ altkey, "Shift"}, "Tab",
        function ()
            alttab.switch(-1, "Alt_L", "Tab", "ISO_Left_Tab")
        end,
        {description = "switch clients", group = "awesome"}
    )
)

--Tag swapping
local tagkeys = awful.util.table.join(
    awful.key(
        { modkey }, "Left",
        awful.tag.viewprev,
        {description = "view previous tag", group = "tag"}
    ),
    awful.key(
        { modkey }, "Right",
        awful.tag.viewnext,
        {description = "view next tag", group = "tag"}
    ),
    awful.key(
        { modkey }, "Tab",
        awful.tag.history.restore,
        {description = "switch between tags", group = "tag"}
    )
)

-- keybindings for layout switching
local layout_keys = awful.util.table.join(
    awful.key(
        { modkey }, "space", 
        function () 
            awful.layout.inc( 1)
        end,
        {description = "select next layout", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift" }, "space", 
        function () 
            awful.layout.inc(-1)
        end,
        {description = "select previous layout", group = "layout"}
    )
)

local enable_switching = function(maximumTags)end

local bindings = awful.util.table.join(
    util_keys,
    launcher_keys,
    layout_keys
)

-- define all the key bindings specifically for the clients
-- e.g toggle fullscreen, minimize, close
local client_keys = awful.util.table.join(
    awful.key(
        { modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        { modkey, "Shift" }, "c",
        function (c) 
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key(
        { modkey }, "t",
        function (c) 
            c.ontop = not c.ontop
        end,
        {description = "toggle keep on top", group = "client"}
    ),
    awful.key(
        { modkey }, "n",
        function (c)
-- The client currently has the input focus, so it cannot be
-- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}
    ),
    awful.key(
        { modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"}
    )
)

return { 
    bindings = bindings,
    clientkeys = client_keys
}
