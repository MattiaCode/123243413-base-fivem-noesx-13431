local playersWithStartingItems = {}

RegisterServerEvent('base:playerLoaded')
AddEventHandler('base:playerLoaded', function()
    local source = source
    print('Player ' .. source .. ' loaded')
end)

RegisterServerEvent('base:giveStartingItems')
AddEventHandler('base:giveStartingItems', function()
    local source = source

    if playersWithStartingItems[source] then
        return
    end

    playersWithStartingItems[source] = true

    for _, item in pairs(Config.StartingItems) do
        exports.ox_inventory:AddItem(source, item.name, item.count, item.metadata)
    end

    print('Player ' .. source .. ' received starting items')
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    deferrals.defer()

    local player = source

    Wait(100)

    deferrals.update('Verifica in corso...')

    Wait(500)

    deferrals.done()
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    playersWithStartingItems[source] = nil
    print('Player ' .. source .. ' disconnected: ' .. reason)
end)
