local traderPed = nil
local nearTraderPed = false

Citizen.CreateThread(function()
    local model = GetHashKey(Config.TraderPed.model)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    traderPed = CreatePed(4, model, Config.TraderPed.coords.x, Config.TraderPed.coords.y, Config.TraderPed.coords.z - 1.0, Config.TraderPed.coords.w, false, true)

    SetEntityHeading(traderPed, Config.TraderPed.coords.w)
    FreezeEntityPosition(traderPed, true)
    SetEntityInvincible(traderPed, true)
    SetBlockingOfNonTemporaryEvents(traderPed, true)

    SetModelAsNoLongerNeeded(model)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if traderPed then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local pedCoords = GetEntityCoords(traderPed)
            local distance = #(playerCoords - pedCoords)

            if distance < 2.5 then
                if not nearTraderPed then
                    nearTraderPed = true
                    lib.showTextUI('[E] - Scambia Ferro', {
                        position = "top-center",
                        icon = 'fa-solid fa-handshake',
                        style = {
                            borderRadius = 5,
                            backgroundColor = '#e67e22',
                            color = 'white'
                        }
                    })
                end

                if IsControlJustPressed(0, 38) then
                    OpenTraderMenu()
                end
            else
                if nearTraderPed then
                    nearTraderPed = false
                    lib.hideTextUI()
                end
            end
        end
    end
end)

function OpenTraderMenu()
    lib.callback('trader:getIronAmount', false, function(ironAmount)
        local options = {}

        table.insert(options, {
            title = 'Il tuo Ferro: ' .. ironAmount,
            description = 'Quantità di ferro disponibile',
            icon = 'hammer',
            disabled = true
        })

        for i, item in pairs(Config.TraderItems) do
            local canAfford = ironAmount >= item.ironCost

            table.insert(options, {
                title = item.label,
                description = 'Costo: ' .. item.ironCost .. ' Ferro',
                icon = canAfford and 'circle-check' or 'circle-xmark',
                iconColor = canAfford and 'green' or 'red',
                disabled = not canAfford,
                onSelect = function()
                    TriggerServerEvent('trader:buyItem', item.name, item.ironCost, item.count or 1)
                    Wait(500)
                    OpenTraderMenu()
                end
            })
        end

        lib.registerContext({
            id = 'trader_menu',
            title = 'Trader - Scambia Ferro',
            options = options
        })

        lib.showContext('trader_menu')
    end)
end
