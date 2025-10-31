local storagePed = nil
local nearStoragePed = false

Citizen.CreateThread(function()
    local model = GetHashKey(Config.StoragePed.model)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    storagePed = CreatePed(4, model, Config.StoragePed.coords.x, Config.StoragePed.coords.y, Config.StoragePed.coords.z - 1.0, Config.StoragePed.coords.w, false, true)

    SetEntityHeading(storagePed, Config.StoragePed.coords.w)
    FreezeEntityPosition(storagePed, true)
    SetEntityInvincible(storagePed, true)
    SetBlockingOfNonTemporaryEvents(storagePed, true)

    SetModelAsNoLongerNeeded(model)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if storagePed then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local pedCoords = GetEntityCoords(storagePed)
            local distance = #(playerCoords - pedCoords)

            if distance < 2.5 then
                if not nearStoragePed then
                    nearStoragePed = true
                    lib.showTextUI('[E] - Vedi oggetti', {
                        position = "top-center",
                        icon = 'fa-solid fa-box',
                        style = {
                            borderRadius = 5,
                            backgroundColor = '#f39c12',
                            color = 'white'
                        }
                    })
                end

                if IsControlJustPressed(0, 38) then
                    TriggerEvent('ox_inventory:openInventory')
                end
            else
                if nearStoragePed then
                    nearStoragePed = false
                    lib.hideTextUI()
                end
            end
        end
    end
end)
