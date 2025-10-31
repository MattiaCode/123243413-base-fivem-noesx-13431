local playerAppearances = {}

RegisterNetEvent('fivem-appearance:save')
AddEventHandler('fivem-appearance:save', function(appearance)
    local source = source
    playerAppearances[source] = appearance
end)

AddEventHandler('playerDropped', function()
    local source = source
    playerAppearances[source] = nil
end)

RegisterNetEvent('fivem-appearance:loadAppearance')
AddEventHandler('fivem-appearance:loadAppearance', function()
    local source = source

    if playerAppearances[source] then
        TriggerClientEvent('fivem-appearance:load', source, playerAppearances[source])
    end
end)
