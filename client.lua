local veh = nil
local inVehicle = false

local function convertSpeed(speed)
    if Config.SpeedUnit == "mph" then
        return speed * 2.237
    else
        return speed * 3.6 
    end
end

local function getSpeedUnit()
    if Config.SpeedUnit == "mph" then
        return "mph"
    else
        return "km/h"
    end
end

local function debugPrint(message)
    if Config.Debug then
        print("[Speed HUD] " .. message)
    end
end

CreateThread(function()
    Wait(1000)
    debugPrint("Initializing Speed HUD...")
    
    SendNUIMessage({
        action = "init",
        speedUnit = getSpeedUnit(),
        hudStyle = Config.HudStyle,
        hudPosition = Config.HudPosition
    })

    SendNUIMessage({
        action = "toggleHud",
        showSpeedHud = false
    })
    
    Wait(100)
    
    SendNUIMessage({
        action = "toggleHud",
        showSpeedHud = false
    })
    debugPrint("Speed HUD initialized with unit: " .. getSpeedUnit())
    while true do
        local playerPed = PlayerPedId()
        local currentVeh = GetVehiclePedIsIn(playerPed, false)
        if currentVeh ~= 0 then
            if not inVehicle then
                veh = currentVeh
                inVehicle = true
                debugPrint("Player entered vehicle")
                SendNUIMessage({
                    action = "toggleHud",
                    showSpeedHud = true
                })
            end
            if DoesEntityExist(currentVeh) then
                local speed = GetEntitySpeed(currentVeh)
                local convertedSpeed = convertSpeed(speed)
                SendNUIMessage({
                    action = "updateSpeed",
                    speed = math.floor(convertedSpeed)
                })
            end
            Wait(Config.UpdateInterval.inVehicle)
        else
            if inVehicle then
                inVehicle = false
                veh = nil
                debugPrint("Player exited vehicle")
                SendNUIMessage({
                    action = "toggleHud",
                    showSpeedHud = false
                })
            end
            Wait(Config.UpdateInterval.outVehicle)
        end
    end
end)

AddEventHandler('playerSpawned', function()
    Wait(500)
    debugPrint("Player spawned - ensuring HUD is hidden")
    SendNUIMessage({
        action = "toggleHud",
        showSpeedHud = false
    })
end)