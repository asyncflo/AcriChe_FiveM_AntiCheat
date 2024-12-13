-- client.lua

Citizen.CreateThread(function()
    local playerPed, playerId
    while true do
        Citizen.Wait(500) -- Überprüfungsintervall (0,5 Sekunden)

        playerPed = PlayerPedId()
        playerId = PlayerId()

        -- Prüfe auf Godmode
        local health = GetEntityHealth(playerPed)
        if health > Config.MaxHealth then
            TriggerServerEvent("acriChe:banPlayer", "godmode")
        end

        -- Prüfe auf Fliegen
        local isInAir = not IsPedOnFoot(playerPed) and not IsPedInAnyVehicle(playerPed, false) and not IsPedFalling(playerPed)
        local heightAboveGround = GetEntityHeightAboveGround(playerPed)
        if isInAir and heightAboveGround > Config.MaxFlyHeight then
            TriggerServerEvent("acriChe:banPlayer", "fly")
        end

        -- Prüfe auf Geschwindigkeit
        local speed = GetEntitySpeed(playerPed)
        if not IsPedInAnyVehicle(playerPed, false) and speed > Config.MaxRunningSpeed then -- Zu schnelles Laufen
            TriggerServerEvent("acriChe:banPlayer", "speedhack")
        elseif IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local vehicleSpeed = GetEntitySpeed(vehicle) * 3.6 -- Geschwindigkeit in km/h
            if vehicleSpeed > Config.MaxVehicleSpeed then -- Zu schnelles Fahren
                TriggerServerEvent("acriChe:banPlayer", "speedhack_vehicle")
            end
        end

        -- Prüfe auf unerlaubte Waffen
        local weaponHash = GetSelectedPedWeapon(playerPed)
        if weaponHash == GetHashKey("WEAPON_RAILGUN") then
            TriggerServerEvent("acriChe:banPlayer", "illegal_weapon")
        end
    end
end)
