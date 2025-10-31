local inventoryOpen = false
local currentInventory = {
    items = {},
    weight = 0,
    maxWeight = Config.MaxWeight,
    slots = Config.MaxSlots
}

RegisterNetEvent('ox_inventory:updateInventory')
AddEventHandler('ox_inventory:updateInventory', function(inventory)
    currentInventory = inventory
    if inventoryOpen then
        SendNUIMessage({
            type = 'updateInventory',
            inventory = inventory,
            items = Items
        })
    end
end)

RegisterNetEvent('ox_inventory:itemUsed')
AddEventHandler('ox_inventory:itemUsed', function(item, itemData)
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"Sistema", "Hai usato: " .. itemData.label}
    })
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if IsControlJustPressed(0, 289) then
            ToggleInventory()
        end
    end
end)

function ToggleInventory()
    inventoryOpen = not inventoryOpen

    if inventoryOpen then
        TriggerServerEvent('ox_inventory:requestInventory')
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'openInventory',
            inventory = currentInventory,
            items = Items
        })
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = 'closeInventory'
        })
    end
end

RegisterNUICallback('closeInventory', function(data, cb)
    inventoryOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('useItem', function(data, cb)
    TriggerServerEvent('ox_inventory:useItem', data.item)
    cb('ok')
end)
