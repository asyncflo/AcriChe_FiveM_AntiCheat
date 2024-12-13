-- server.lua

local BannedPlayers = {}

-- Event-Blacklist-Überprüfung
for _, eventName in ipairs(Config.BlacklistedEvents) do
    RegisterServerEvent(eventName)
    AddEventHandler(eventName, function(...)
        local src = source
        print("^1Blocked blacklisted event: ^0"..eventName.." from player: "..GetPlayerName(src))
        TriggerEvent("acriChe:banPlayer", src, "blacklisted_event")
    end)
end

-- Spieler bannen
RegisterNetEvent("acriChe:banPlayer")
AddEventHandler("acriChe:banPlayer", function(playerId, reasonKey)
    local reason = Config.BanReasons[reasonKey] or "Unknown reason"
    local identifiers = GetPlayerIdentifiers(playerId)
    table.insert(BannedPlayers, {id = identifiers[1], reason = reason})
    DropPlayer(playerId, "You have been banned: "..reason)

    -- Log in Discord
    sendToDiscord("AcriChe Ban", "**Player:** "..GetPlayerName(playerId).."\n**Reason:** "..reason.."\n**Identifiers:** "..json.encode(identifiers))
end)

-- Spieler-Whitelist/Ban-Check
AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    deferrals.defer()
    local src = source
    local steamId = GetPlayerIdentifiers(src)[1]
    for _, banned in ipairs(BannedPlayers) do
        if banned.id == steamId then
            setKickReason("You are banned: "..banned.reason)
            deferrals.done()
            return
        end
    end
    deferrals.done()
end)

-- Discord-Benachrichtigung
function sendToDiscord(title, message)
    local payload = json.encode({
        username = "AcriChe",
        embeds = {{
            title = title,
            description = message,
            color = 15158332, -- Rot
        }}
    })
    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, "POST", payload, {["Content-Type"] = "application/json"})
end
