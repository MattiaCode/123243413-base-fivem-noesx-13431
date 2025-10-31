local inSafeZone = false
local currentZone = nil

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())

        DrawMarker(
            Config.MainSafeZone.markerType,
            Config.MainSafeZone.coords.x,
            Config.MainSafeZone.coords.y,
            Config.MainSafeZone.coords.z - 1.0,
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            Config.MainSafeZone.radius * 2.0,
            Config.MainSafeZone.radius * 2.0,
            2.0,
            Config.MainSafeZone.markerColor.r,
            Config.MainSafeZone.markerColor.g,
            Config.MainSafeZone.markerColor.b,
            Config.MainSafeZone.markerColor.a,
            false, false, 2, false, nil, nil, false
        )

        for i, zone in pairs(Config.TeleportLocations) do
            DrawMarker(
                1,
                zone.coords.x,
                zone.coords.y,
                zone.coords.z - 1.0,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                zone.radius * 2.0,
                zone.radius * 2.0,
                2.0,
                0, 255, 0, 100,
                false, false, 2, false, nil, nil, false
            )
        end

        local distanceMain = #(playerCoords - Config.MainSafeZone.coords)
        local wasInSafeZone = inSafeZone

        if distanceMain <= Config.MainSafeZone.radius then
            if not inSafeZone then
                inSafeZone = true
                currentZone = 'main'
                TriggerEvent('base:enteredSafeZone', 'main')
            end
        else
            local foundZone = false
            for i, zone in pairs(Config.TeleportLocations) do
                local distance = #(playerCoords - zone.coords)
                if distance <= zone.radius then
                    if not inSafeZone or currentZone ~= zone.label then
                        inSafeZone = true
                        currentZone = zone.label
                        TriggerEvent('base:enteredSafeZone', zone.label)
                    end
                    foundZone = true
                    break
                end
            end

            if not foundZone and inSafeZone then
                inSafeZone = false
                currentZone = nil
                TriggerEvent('base:leftSafeZone')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if inSafeZone then
            local ped = PlayerPedId()
            SetEntityInvincible(ped, true)
            SetPlayerInvincible(PlayerId(), true)

            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)

            DisablePlayerFiring(PlayerId(), true)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
        else
            local ped = PlayerPedId()
            SetEntityInvincible(ped, false)
            SetPlayerInvincible(PlayerId(), false)
        end
    end
end)

AddEventHandler('base:enteredSafeZone', function(zoneName)
    lib.notify({
        title = 'Safe Zone',
        description = 'Sei entrato nella safe zone! Non puoi sparare o essere ucciso.',
        type = 'success'
    })
end)

AddEventHandler('base:leftSafeZone', function()
    lib.notify({
        title = 'Safe Zone',
        description = 'Sei uscito dalla safe zone!',
        type = 'warning'
    })
end)
