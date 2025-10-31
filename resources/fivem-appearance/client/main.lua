local cam = nil
local customizationSave = {}

function OpenClothingMenu()
    local playerPed = PlayerPedId()

    SetNuiFocus(true, true)

    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    SetCamCoord(cam, coords.x + 2.0, coords.y + 2.0, coords.z + 0.5)
    PointCamAtEntity(cam, playerPed, 0.0, 0.0, 0.0, true)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)

    SendNUIMessage({
        action = 'open'
    })
end

function CloseClothingMenu()
    SetNuiFocus(false, false)

    if cam then
        RenderScriptCams(false, true, 500, true, true)
        DestroyCam(cam, false)
        cam = nil
    end

    SendNUIMessage({
        action = 'close'
    })
end

RegisterCommand('appearance', function()
    local inSafeZone = exports.base_core:IsPlayerInAnySafeZone()

    if inSafeZone then
        OpenClothingMenu()
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Devi essere in una safe zone per cambiare aspetto!"}
        })
    end
end)

RegisterNUICallback('close', function(data, cb)
    CloseClothingMenu()
    cb('ok')
end)

RegisterNUICallback('saveAppearance', function(data, cb)
    TriggerServerEvent('fivem-appearance:save', data)
    CloseClothingMenu()
    cb('ok')
end)

RegisterNUICallback('updateClothes', function(data, cb)
    local playerPed = PlayerPedId()

    if data.component then
        SetPedComponentVariation(playerPed, data.component, data.drawable, data.texture, 0)
    end

    if data.prop then
        if data.drawable == -1 then
            ClearPedProp(playerPed, data.prop)
        else
            SetPedPropIndex(playerPed, data.prop, data.drawable, data.texture, true)
        end
    end

    cb('ok')
end)

RegisterNetEvent('fivem-appearance:load')
AddEventHandler('fivem-appearance:load', function(appearance)
    if appearance then
        local playerPed = PlayerPedId()

        if appearance.model then
            local model = GetHashKey(appearance.model)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(100)
            end
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
        end

        if appearance.components then
            for i, comp in pairs(appearance.components) do
                SetPedComponentVariation(playerPed, tonumber(i), comp.drawable, comp.texture, 0)
            end
        end

        if appearance.props then
            for i, prop in pairs(appearance.props) do
                if prop.drawable == -1 then
                    ClearPedProp(playerPed, tonumber(i))
                else
                    SetPedPropIndex(playerPed, tonumber(i), prop.drawable, prop.texture, true)
                end
            end
        end
    end
end)
