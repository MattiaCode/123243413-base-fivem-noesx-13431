local Inventories = {}

function GetPlayerInventory(source)
    if not Inventories[source] then
        Inventories[source] = {
            items = {},
            weight = 0,
            maxWeight = Config.MaxWeight,
            slots = Config.MaxSlots
        }
    end
    return Inventories[source]
end

function AddItem(source, item, count, metadata)
    local inventory = GetPlayerInventory(source)
    local itemData = Items[item]

    if not itemData then
        return false
    end

    local totalWeight = inventory.weight + (itemData.weight * count)

    if totalWeight > inventory.maxWeight then
        return false
    end

    local existingItem = nil
    for k, v in pairs(inventory.items) do
        if v.name == item and itemData.stack then
            existingItem = v
            break
        end
    end

    if existingItem then
        existingItem.count = existingItem.count + count
    else
        table.insert(inventory.items, {
            name = item,
            label = itemData.label,
            count = count,
            weight = itemData.weight,
            metadata = metadata or {}
        })
    end

    inventory.weight = totalWeight

    TriggerClientEvent('ox_inventory:updateInventory', source, inventory)

    return true
end

function RemoveItem(source, item, count)
    local inventory = GetPlayerInventory(source)

    for k, v in pairs(inventory.items) do
        if v.name == item then
            if v.count >= count then
                v.count = v.count - count
                inventory.weight = inventory.weight - (v.weight * count)

                if v.count <= 0 then
                    table.remove(inventory.items, k)
                end

                TriggerClientEvent('ox_inventory:updateInventory', source, inventory)
                return true
            end
        end
    end

    return false
end

function GetItem(source, item)
    local inventory = GetPlayerInventory(source)

    for k, v in pairs(inventory.items) do
        if v.name == item then
            return v
        end
    end

    return nil
end

RegisterNetEvent('ox_inventory:requestInventory')
AddEventHandler('ox_inventory:requestInventory', function()
    local source = source
    local inventory = GetPlayerInventory(source)
    TriggerClientEvent('ox_inventory:updateInventory', source, inventory)
end)

RegisterNetEvent('ox_inventory:useItem')
AddEventHandler('ox_inventory:useItem', function(item)
    local source = source
    local itemData = GetItem(source, item)

    if itemData then
        TriggerClientEvent('ox_inventory:itemUsed', source, item, itemData)
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    Inventories[source] = nil
end)

exports('AddItem', AddItem)
exports('RemoveItem', RemoveItem)
exports('GetItem', GetItem)
exports('GetPlayerInventory', GetPlayerInventory)
