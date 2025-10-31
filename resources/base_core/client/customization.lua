local clothingMenuOpen = false

RegisterCommand('vestiti', function()
    if IsPlayerInSafeZone() then
        OpenClothingMenu()
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Devi essere nella safe zone per cambiare i vestiti!"}
        })
    end
end)

function OpenClothingMenu()
    clothingMenuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openClothing"
    })
end

RegisterNUICallback('closeClothing', function(data, cb)
    clothingMenuOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('changeClothing', function(data, cb)
    local ped = PlayerPedId()

    if data.componentId and data.drawableId and data.textureId then
        SetPedComponentVariation(ped, tonumber(data.componentId), tonumber(data.drawableId), tonumber(data.textureId), 0)
    end

    cb('ok')
end)

RegisterNUICallback('changeProp', function(data, cb)
    local ped = PlayerPedId()

    if data.componentId and data.drawableId and data.textureId then
        if tonumber(data.drawableId) == -1 then
            ClearPedProp(ped, tonumber(data.componentId))
        else
            SetPedPropIndex(ped, tonumber(data.componentId), tonumber(data.drawableId), tonumber(data.textureId), true)
        end
    end

    cb('ok')
end)

RegisterNUICallback('getClothingData', function(data, cb)
    local ped = PlayerPedId()
    local clothingData = {}

    for i = 0, 11 do
        local drawable = GetNumberOfPedDrawableVariations(ped, i)
        clothingData[i] = {
            max = drawable - 1,
            current = GetPedDrawableVariation(ped, i),
            texture = GetPedTextureVariation(ped, i)
        }
    end

    cb(clothingData)
end)
