Config = {}

-- Speed unit configuration
Config.SpeedUnit = "kmh" -- Options: "kmh" or "mph"

-- HUD Position
Config.HudPosition = {
    bottom = 15, -- pixels from bottom
    right = 15   -- pixels from right
}

-- Update intervals (in milliseconds)
Config.UpdateInterval = {
    inVehicle = 50,  -- How often to update speed when in vehicle
    outVehicle = 500 -- How often to check if player is in vehicle
}

-- HUD appearance
Config.HudStyle = {
    showIcon = true,           -- Show speedometer icon
    backgroundColor = "rgba(0, 0, 0, 0.8)",
    borderColor = "rgba(255, 255, 255, 0.1)",
    textColor = "#ffffff"
}

-- Debug mode (shows console messages)
Config.Debug = false