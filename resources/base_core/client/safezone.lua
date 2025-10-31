local inSafeZone = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - Config.SafeZone.coords)

        DrawMarker(
            Config.SafeZone.markerType,
            Config.SafeZone.coords.x,
            Config.SafeZone.coords.y,
            Config.SafeZone.coords.z - 1.0,
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            Config.SafeZone.radius * 2.0,
            Config.SafeZone.radius * 2.0,
            2.0,
            Config.SafeZone.markerColor.r,
            Config.SafeZone.markerColor.g,
            Config.SafeZone.markerColor.b,
            Config.SafeZone.markerColor.a,
            false, false, 2, false, nil, nil, false
        )

        if distance <= Config.SafeZone.radius then
            if not inSafeZone then
                inSafeZone = true
                TriggerEvent('base:enteredSafeZone')
            end
        else
            if inSafeZone then
                inSafeZone = false
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
        else
            local ped = PlayerPedId()
            SetEntityInvincible(ped, false)
            SetPlayerInvincible(PlayerId(), false)
        end
    end
end)

RegisterCommand('moto', function()
    if inSafeZone then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)

        local vehicleModel = GetHashKey('bf400')

        RequestModel(vehicleModel)
        while not HasModelLoaded(vehicleModel) do
            Wait(100)
        end

        local vehicle = CreateVehicle(vehicleModel, coords.x + 2.0, coords.y, coords.z, heading, true, false)

        SetVehicleNumberPlateText(vehicle, "SAFEZONE")
        SetEntityAsMissionEntity(vehicle, true, true)
        SetModelAsNoLongerNeeded(vehicleModel)

        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"Sistema", "BF400 spawnata!"}
        })
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Devi essere nella safe zone per usare questo comando!"}
        })
    end
end)

AddEventHandler('base:enteredSafeZone', function()
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Safe Zone", "Sei entrato nella safe zone! Sei invincibile."}
    })
end)

AddEventHandler('base:leftSafeZone', function()
    TriggerEvent('chat:addMessage', {
        color = {255, 165, 0},
        multiline = true,
        args = {"Safe Zone", "Sei uscito dalla safe zone!"}
    })
end)
