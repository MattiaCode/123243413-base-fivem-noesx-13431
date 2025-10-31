local currentVehicle = nil

RegisterCommand('moto', function()
    local inSafeZone = exports.base_core:IsPlayerInAnySafeZone()

    if inSafeZone then
        SpawnVehicle('bf400')
    else
        lib.notify({
            title = 'Errore',
            description = 'Devi essere in una safe zone per spawnare veicoli!',
            type = 'error'
        })
    end
end)

RegisterCommand('macchina', function()
    local inSafeZone = exports.base_core:IsPlayerInAnySafeZone()

    if inSafeZone then
        SpawnVehicle('adder')
    else
        lib.notify({
            title = 'Errore',
            description = 'Devi essere in una safe zone per spawnare veicoli!',
            type = 'error'
        })
    end
end)

function SpawnVehicle(model)
    if currentVehicle and DoesEntityExist(currentVehicle) then
        DeleteEntity(currentVehicle)
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    local vehicleModel = GetHashKey(model)

    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(100)
    end

    currentVehicle = CreateVehicle(vehicleModel, coords.x + 2.0, coords.y, coords.z, heading, true, false)

    SetVehicleNumberPlateText(currentVehicle, "CUSTOM")
    SetEntityAsMissionEntity(currentVehicle, true, true)
    SetModelAsNoLongerNeeded(vehicleModel)

    lib.notify({
        title = 'Veicolo',
        description = 'Veicolo spawnato! Premi F per eliminarlo.',
        type = 'success'
    })
end

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            if vehicle == currentVehicle then
                lib.showTextUI('[F] - Elimina veicolo', {
                    position = "top-center",
                    icon = 'fa-solid fa-trash',
                    style = {
                        borderRadius = 5,
                        backgroundColor = '#e74c3c',
                        color = 'white'
                    }
                })

                if IsControlJustPressed(0, 23) then
                    DeleteVehicle(vehicle)
                    currentVehicle = nil
                    lib.hideTextUI()

                    lib.notify({
                        title = 'Veicolo',
                        description = 'Veicolo eliminato!',
                        type = 'success'
                    })
                end
            else
                lib.hideTextUI()
            end
        else
            lib.hideTextUI()
        end
    end
end)
