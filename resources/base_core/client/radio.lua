local radioFrequency = 0
local inRadio = false
local currentRadioAnim = 1

RegisterCommand('radiof', function(source, args)
    if not args[1] then
        lib.notify({
            title = 'Radio',
            description = 'Uso: /radiof [frequenza]',
            type = 'error'
        })
        return
    end

    local frequency = tonumber(args[1])

    if not frequency then
        lib.notify({
            title = 'Radio',
            description = 'Frequenza non valida!',
            type = 'error'
        })
        return
    end

    radioFrequency = frequency
    inRadio = true

    exports.pma_voice:setVoiceProperty('radioEnabled', true)
    exports.pma_voice:setRadioChannel(frequency)

    lib.notify({
        title = 'Radio',
        description = 'Sei entrato nella frequenza ' .. frequency,
        type = 'success'
    })
end)

RegisterCommand('radiooff', function()
    if not inRadio then
        lib.notify({
            title = 'Radio',
            description = 'Non sei in una frequenza radio!',
            type = 'error'
        })
        return
    end

    radioFrequency = 0
    inRadio = false

    exports.pma_voice:setVoiceProperty('radioEnabled', false)
    exports.pma_voice:setRadioChannel(0)

    lib.notify({
        title = 'Radio',
        description = 'Sei uscito dalla frequenza radio',
        type = 'info'
    })
end)

RegisterCommand('radioanim', function()
    if not inRadio then
        lib.notify({
            title = 'Radio',
            description = 'Devi essere in una frequenza radio!',
            type = 'error'
        })
        return
    end

    OpenRadioAnimMenu()
end)

function OpenRadioAnimMenu()
    local options = {}

    for i, anim in pairs(Config.RadioAnimations) do
        table.insert(options, {
            title = anim.label,
            icon = 'signal',
            onSelect = function()
                currentRadioAnim = i
                lib.notify({
                    title = 'Radio',
                    description = 'Animazione cambiata: ' .. anim.label,
                    type = 'success'
                })
            end
        })
    end

    lib.registerContext({
        id = 'radio_anim_menu',
        title = 'Animazioni Radio',
        options = options
    })

    lib.showContext('radio_anim_menu')
end

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if inRadio then
            if NetworkIsPlayerTalking(PlayerId()) then
                local ped = PlayerPedId()
                local animData = Config.RadioAnimations[currentRadioAnim]

                if animData then
                    RequestAnimDict(animData.dict)
                    while not HasAnimDictLoaded(animData.dict) do
                        Wait(100)
                    end

                    if not IsEntityPlayingAnim(ped, animData.dict, animData.anim, 3) then
                        TaskPlayAnim(ped, animData.dict, animData.anim, 8.0, -8.0, -1, 49, 0, false, false, false)
                    end
                end
            else
                local ped = PlayerPedId()
                StopAnimTask(ped, Config.RadioAnimations[currentRadioAnim].dict, Config.RadioAnimations[currentRadioAnim].anim, 3.0)
            end
        end
    end
end)
