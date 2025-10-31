local insideRedZone = false
local activeZones = {}

Citizen.CreateThread(function()
    for i, zone in pairs(Config.RedZones) do
        local zoneId = lib.zones.poly({
            points = zone.points,
            thickness = zone.maxZ - zone.minZ,
            debug = false,
            inside = function()
                if not insideRedZone then
                    insideRedZone = true
                    lib.notify({
                        title = 'Zona Rossa',
                        description = 'Sei entrato in una zona PVP! Attenzione!',
                        type = 'error'
                    })
                end
            end,
            onExit = function()
                if insideRedZone then
                    insideRedZone = false
                    lib.notify({
                        title = 'Zona Rossa',
                        description = 'Sei uscito dalla zona PVP',
                        type = 'info'
                    })
                end
            end
        })

        activeZones[i] = zoneId
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        for i, zone in pairs(Config.RedZones) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local avgX, avgY = 0, 0
            local numPoints = #zone.points

            for _, point in ipairs(zone.points) do
                avgX = avgX + point.x
                avgY = avgY + point.y
            end

            avgX = avgX / numPoints
            avgY = avgY / numPoints

            DrawMarker(
                28,
                avgX,
                avgY,
                zone.minZ,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                50.0, 50.0, zone.maxZ - zone.minZ,
                255, 0, 0, 100,
                false, false, 2, false, nil, nil, false
            )
        end
    end
end)

exports('IsInRedZone', function()
    return insideRedZone
end)
