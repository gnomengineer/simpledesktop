local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local alttab = require("awesome-switcher-preview")
local conky = require("conkyHUD")

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
            conky.toggleConky()
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
            awful.spawn("i3lock -u -i /usr/share/awesome/themes/default/lockscreen.png")
        end,
        {description="lock the screen", group="awesome"}
    ),
    awful.key(
        { }, "Print",
        function()
           awful.spawn("scrot -u '~/screenshot_%y%m%d_%T.png'")
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
    ),
    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
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

local function setTagSwitching(maximumTags) 
    if maximumTags > 9 then
        maximumTags = 9
    end
    for i = 1, maximumTags do
        tagkeys = awful.util.table.join(
            tagkeys,
            -- View tag only.
            awful.key({ modkey }, "#" .. i + 9,
                      function ()
                            local screen = awful.screen.focused()
                            local tag = screen.tags[i]
                            if tag then
                               tag:view_only()
                            end
                      end,
                      {description = "view tag #"..i, group = "tag"}),
            -- Toggle tag display.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                      function ()
                          local screen = awful.screen.focused()
                          local tag = screen.tags[i]
                          if tag then
                             awful.tag.viewtoggle(tag)
                          end
                      end,
                      {description = "toggle tag #" .. i, group = "tag"}),
            -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:move_to_tag(tag)
                              end
                         end
                      end,
                      {description = "move focused client to tag #"..i, group = "tag"}),
            -- Toggle tag on focused client.
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:toggle_tag(tag)
                              end
                          end
                      end,
                      {description = "toggle focused client on tag #" .. i, group = "tag"})
            )
    end
end

local function setAwesomeUtility(awesome)
    awful.util.table.join(
        util_keys,
        awful.key(
            { modkey,"Shift" }, "r",
            awesome.restart,
            {description = "reload awesome", group = "awesome"}
        ),
        awful.key(
            { modkey, "Shift"   }, "q",
            awesome.quit,
            {description = "quit awesome", group = "awesome"}
        )
    )
end

local function getGlobalKeys()
    return awful.util.table.join(
        util_keys,
        launcher_keys,
        layout_keys,
        tagkeys
    )
end

-- define all the key bindings specifically for the clients
-- e.g toggle fullscreen, minimize, close
local function getClientKeys()
    client_keys = awful.util.table.join(
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
    return client_keys
end

return { 
    setTagSwitching = setTagSwitching,
    setAwesomeUtility = setAwesomeUtility,
    getGlobalKeys = getGlobalKeys,
    getClientKeys = getClientKeys
}
