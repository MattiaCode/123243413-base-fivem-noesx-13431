local shopPed = nil
local nearShopPed = false

Citizen.CreateThread(function()
    local model = GetHashKey(Config.ShopPed.model)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    shopPed = CreatePed(4, model, Config.ShopPed.coords.x, Config.ShopPed.coords.y, Config.ShopPed.coords.z - 1.0, Config.ShopPed.coords.w, false, true)

    SetEntityHeading(shopPed, Config.ShopPed.coords.w)
    FreezeEntityPosition(shopPed, true)
    SetEntityInvincible(shopPed, true)
    SetBlockingOfNonTemporaryEvents(shopPed, true)

    SetModelAsNoLongerNeeded(model)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if shopPed then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local pedCoords = GetEntityCoords(shopPed)
            local distance = #(playerCoords - pedCoords)

            if distance < 2.5 then
                if not nearShopPed then
                    nearShopPed = true
                    lib.showTextUI('[E] - Apri negozio', {
                        position = "top-center",
                        icon = 'fa-solid fa-shop',
                        style = {
                            borderRadius = 5,
                            backgroundColor = '#3498db',
                            color = 'white'
                        }
                    })
                end

                if IsControlJustPressed(0, 38) then
                    OpenShopMenu()
                end
            else
                if nearShopPed then
                    nearShopPed = false
                    lib.hideTextUI()
                end
            end
        end
    end
end)

function OpenShopMenu()
    local options = {}

    for i, item in pairs(Config.ShopItems) do
        table.insert(options, {
            title = item.label,
            description = 'Prezzo: $' .. item.price,
            icon = 'dollar-sign',
            onSelect = function()
                TriggerServerEvent('base:buyItem', item.name, item.price)
            end
        })
    end

    lib.registerContext({
        id = 'shop_menu',
        title = 'Negozio',
        options = options
    })

    lib.showContext('shop_menu')
end
