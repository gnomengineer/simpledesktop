local battery = {}
local naughty = require("naughty")

local function trim(s)
  return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function readIO(path)
    return assert(io.open("/sys/class/power_supply/BAT0/"..path,"r"))
end

local function getString(path)
    return trim(readIO(path):read("*all"))
end

local function getNumber(path)
    return tonumber(readIO(path):read("*all"))
end

function battery.checkBattery()
    local capacity = getNumber("capacity")
    local status = getString("status")
    local power = getNumber("power_now")
    local energy = getNumber("energy_now")

    local time = energy / power * 60
    local minutes = math.floor(time % 60)
    local hours = math.floor((time - minutes) / 60)

    if status == "Discharging" and capacity <= 10 then
        naughty.notify({ 
            preset =  naughty.config.presets.critical,
            title = "testoutput",
            text = capacity .. "% " ..hours .. ":"..minutes .." remianing."})
    end
end

function battery.start(delta,callback)
    delta = 10
    timer = timer({timeout = delta})
    timer:connect_signal("timeout", callback)
    timer:start()
end

return battery
