RegisterServerEvent('base:playerLoaded')
AddEventHandler('base:playerLoaded', function()
    local source = source
    print('Player ' .. source .. ' loaded')
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
    print('Player ' .. source .. ' disconnected: ' .. reason)
end)
