local teleportPed = nil
local nearTeleportPed = false

Citizen.CreateThread(function()
    local model = GetHashKey(Config.TeleportPed.model)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    teleportPed = CreatePed(4, model, Config.TeleportPed.coords.x, Config.TeleportPed.coords.y, Config.TeleportPed.coords.z - 1.0, Config.TeleportPed.coords.w, false, true)

    SetEntityHeading(teleportPed, Config.TeleportPed.coords.w)
    FreezeEntityPosition(teleportPed, true)
    SetEntityInvincible(teleportPed, true)
    SetBlockingOfNonTemporaryEvents(teleportPed, true)

    SetModelAsNoLongerNeeded(model)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if teleportPed then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local pedCoords = GetEntityCoords(teleportPed)
            local distance = #(playerCoords - pedCoords)

            if distance < 2.5 then
                if not nearTeleportPed then
                    nearTeleportPed = true
                    lib.showTextUI('[E] - Scegli dove andare', {
                        position = "top-center",
                        icon = 'fa-solid fa-plane-departure',
                        style = {
                            borderRadius = 5,
                            backgroundColor = '#667eea',
                            color = 'white'
                        }
                    })
                end

                if IsControlJustPressed(0, 38) then
                    OpenTeleportMenu()
                end
            else
                if nearTeleportPed then
                    nearTeleportPed = false
                    lib.hideTextUI()
                end
            end
        end
    end
end)

function OpenTeleportMenu()
    local options = {}

    for i, location in pairs(Config.TeleportLocations) do
        table.insert(options, {
            title = location.label,
            description = 'Teletrasportati a ' .. location.label,
            icon = 'location-dot',
            onSelect = function()
                TeleportToLocation(location.coords)
            end
        })
    end

    lib.registerContext({
        id = 'teleport_menu',
        title = 'Seleziona Destinazione',
        options = options
    })

    lib.showContext('teleport_menu')
end

function TeleportToLocation(coords)
    local ped = PlayerPedId()

    DoScreenFadeOut(500)
    Wait(500)

    SetEntityCoords(ped, coords.x, coords.y, coords.z, false, false, false, true)

    Wait(500)
    DoScreenFadeIn(500)

    lib.notify({
        title = 'Teletrasporto',
        description = 'Sei stato teletrasportato!',
        type = 'success'
    })
end
