local deathBags = {}
local bagIdCounter = 0

RegisterServerEvent('base:createDeathBag')
AddEventHandler('base:createDeathBag', function(coords)
    local source = source
    local playerInventory = exports.ox_inventory:GetPlayerInventory(source)

    if not playerInventory or not playerInventory.items then
        return
    end

    local bagItems = {}

    for k, item in pairs(playerInventory.items) do
        if item.name ~= 'backpack' then
            local itemsInBackpack = false

            if not itemsInBackpack then
                table.insert(bagItems, {
                    name = item.name,
                    label = item.label,
                    count = item.count,
                    metadata = item.metadata or {}
                })

                exports.ox_inventory:RemoveItem(source, item.name, item.count)
            end
        end
    end

    if #bagItems > 0 then
        bagIdCounter = bagIdCounter + 1
        local bagId = 'bag_' .. bagIdCounter

        deathBags[bagId] = {
            coords = coords,
            items = bagItems
        }

        TriggerClientEvent('base:createBagClient', -1, bagId, coords, bagItems)

        SetTimeout(300000, function()
            if deathBags[bagId] then
                deathBags[bagId] = nil
                TriggerClientEvent('base:removeBag', -1, bagId)
            end
        end)
    end
end)

RegisterServerEvent('base:takeBagItem')
AddEventHandler('base:takeBagItem', function(bagId, itemIndex)
    local source = source

    if not deathBags[bagId] then
        return
    end

    local item = deathBags[bagId].items[itemIndex]

    if not item then
        return
    end

    if exports.ox_inventory:AddItem(source, item.name, item.count, item.metadata) then
        table.remove(deathBags[bagId].items, itemIndex)

        TriggerClientEvent('base:updateBag', -1, bagId, deathBags[bagId].items)

        lib.notify(source, {
            title = 'Borsone',
            description = 'Hai preso ' .. item.count .. 'x ' .. item.label,
            type = 'success'
        })

        if #deathBags[bagId].items == 0 then
            deathBags[bagId] = nil
            TriggerClientEvent('base:removeBag', -1, bagId)
        end
    else
        lib.notify(source, {
            title = 'Errore',
            description = 'Inventario pieno!',
            type = 'error'
        })
    end
end)
