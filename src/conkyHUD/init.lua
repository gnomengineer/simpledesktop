local conkyhud = {} 
local conky = nil
local gears = require("gears")
local awful = require("awful")

-- iteration through all clients to find conky
local function get_conky(default)
    if conky and conky.valid then
        return conky
    end

    conky = awful.client.iterate(function(c) return c.class == "Conky" end)()
    return conky or default
end
    
-- raise and lower conky
local function raise_conky()
    get_conky({}).ontop = true
end
local function lower_conky()
    get_conky({}).ontop = false
end
    
-- creates a timer of 0.01s
local t = gears.timer({ timeout = 0.01 })
t:connect_signal("timeout", function()
    t:stop()
    lower_conky()
end)

-- calls a timer 't'
function conkyhud.lower_conky_delayed()
    t:again()
end

-- toggles conky
function conkyhud.toggleConky()
    local conky = get_conky({})
    conky.ontop = not conky.ontop
end

return conkyhud
