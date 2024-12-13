-- config.lua

Config = {}

-- Blacklist von Events, die blockiert werden sollen
Config.BlacklistedEvents = {
    "esx:giveMoney",
    "esx:spawnCar",
    "cheat:teleport",
    "illegal:event",
}

-- Godmode-Erkennung
Config.MaxHealth = 200 -- Maximal erlaubtes Leben

-- Geschwindigkeitserkennung
Config.MaxRunningSpeed = 10.0 -- Maximal erlaubte Laufgeschwindigkeit (m/s)
Config.MaxVehicleSpeed = 250 -- Maximal erlaubte Fahrzeuggeschwindigkeit (km/h)

-- Fliegen-Erkennung
Config.MaxFlyHeight = 10 -- Maximal erlaubte Höhe (über dem Boden)

-- Discord Webhook für Benachrichtigungen
Config.DiscordWebhook = "DEIN_DISCORD_WEBHOOK_LINK"

-- Ban-Grundlagen
Config.BanReasons = {
    ["godmode"] = "Godmode detected.",
    ["blacklisted_event"] = "Blacklisted event triggered.",
    ["illegal_weapon"] = "Illegal weapon detected.",
    ["fly"] = "Flying detected.",
    ["speedhack"] = "Speedhack detected (running).",
    ["speedhack_vehicle"] = "Speedhack detected (vehicle).",
}
