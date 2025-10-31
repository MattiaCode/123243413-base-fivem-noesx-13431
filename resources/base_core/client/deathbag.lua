local bagObjects = {}

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()

        if IsEntityDead(ped) then
            local inRedZone = exports.base_core:IsInRedZone()

            if inRedZone then
                local playerCoords = GetEntityCoords(ped)
                TriggerServerEvent('base:createDeathBag', playerCoords)

                Wait(1000)
            end
        end
    end
end)

RegisterNetEvent('base:createBagClient')
AddEventHandler('base:createBagClient', function(bagId, coords, items)
    local bagModel = GetHashKey('prop_money_bag_01')

    RequestModel(bagModel)
    while not HasModelLoaded(bagModel) do
        Wait(100)
    end

    local bag = CreateObject(bagModel, coords.x, coords.y, coords.z - 0.9, true, true, true)
    PlaceObjectOnGroundProperly(bag)
    FreezeEntityPosition(bag, true)

    SetModelAsNoLongerNeeded(bagModel)

    bagObjects[bagId] = {
        object = bag,
        coords = coords,
        items = items
    }
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())

        for bagId, bagData in pairs(bagObjects) do
            local distance = #(playerCoords - bagData.coords)

            if distance < 2.0 then
                lib.showTextUI('[E] - Perquisici borsone', {
                    position = "top-center",
                    icon = 'fa-solid fa-bag-shopping',
                    style = {
                        borderRadius = 5,
                        backgroundColor = '#e74c3c',
                        color = 'white'
                    }
                })

                if IsControlJustPressed(0, 38) then
                    OpenBagMenu(bagId, bagData.items)
                end
            else
                if distance < 2.5 then
                    lib.hideTextUI()
                end
            end
        end
    end
end)

function OpenBagMenu(bagId, items)
    local options = {}

    for i, item in pairs(items) do
        if item.name ~= 'backpack' then
            local canTake = true
            local description = 'Prendi ' .. item.count .. 'x'

            table.insert(options, {
                title = item.label,
                description = description,
                icon = 'box',
                onSelect = function()
                    TriggerServerEvent('base:takeBagItem', bagId, i)
                end
            })
        end
    end

    if #options == 0 then
        lib.notify({
            title = 'Borsone',
            description = 'Il borsone è vuoto!',
            type = 'error'
        })
        return
    end

    lib.registerContext({
        id = 'bag_menu_' .. bagId,
        title = 'Borsone - Perquisizione',
        options = options
    })

    lib.showContext('bag_menu_' .. bagId)
end

RegisterNetEvent('base:updateBag')
AddEventHandler('base:updateBag', function(bagId, items)
    if bagObjects[bagId] then
        bagObjects[bagId].items = items
    end
end)

RegisterNetEvent('base:removeBag')
AddEventHandler('base:removeBag', function(bagId)
    if bagObjects[bagId] then
        DeleteObject(bagObjects[bagId].object)
        bagObjects[bagId] = nil
    end
end)
