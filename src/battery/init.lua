local battery = {}
local naughty = require("naughty")

local function trim(s)
  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function readIO(path)
    local f = assert(io.open("/sys/class/power_supply/BAT0/"..path,"r"))
    local input = file:read("*all")
    file:close()
    return input
end

local function getString(path)
    return trim(readIO(path))
end

local function getNumber(path)
    return tonumber(readIO(path))
end

function battery.checkBattery()
    if getString("status") == "Discharging" then

        local capacity = getNumber("capacity")

        if capacity <= 10 then
            local power = getNumber("power_now")
            local energy = getNumber("energy_now")

            local time = energy / power * 60
            local minutes = math.floor(time % 60)
            local hours = math.floor((time - minutes) / 60)

            naughty.notify({ 
                preset =  naughty.config.presets.critical,
                title = "testoutput",
                text = capacity .. "% " ..hours .. ":"..minutes .." remianing."})
        end
    end
end

function battery.start(delta,callback)
    delta = 10
    timer = timer({timeout = delta})
    timer:connect_signal("timeout", callback)
    timer:start()
end

return battery
