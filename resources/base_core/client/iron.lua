local blip = nil
local nearMine = false
local isCollecting = false
local lastCollect = 0

Citizen.CreateThread(function()
    blip = AddBlipForCoord(Config.IronMine.coords.x, Config.IronMine.coords.y, Config.IronMine.coords.z)
    SetBlipSprite(blip, Config.IronMine.blipSprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.IronMine.blipScale)
    SetBlipColour(blip, Config.IronMine.blipColor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Miniera di Ferro")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - Config.IronMine.coords)

        if distance < 2.0 then
            if not nearMine then
                nearMine = true
            end

            if not isCollecting then
                lib.showTextUI('[E] - Raccogli Ferro', {
                    position = "top-center",
                    icon = 'fa-solid fa-hammer',
                    style = {
                        borderRadius = 5,
                        backgroundColor = '#95a5a6',
                        color = 'white'
                    }
                })

                if IsControlJustPressed(0, 38) then
                    local currentTime = GetGameTimer()

                    if currentTime - lastCollect < Config.IronMine.cooldown then
                        local remaining = math.ceil((Config.IronMine.cooldown - (currentTime - lastCollect)) / 1000)
                        lib.notify({
                            title = 'Miniera',
                            description = 'Devi aspettare ancora ' .. remaining .. ' secondi!',
                            type = 'error'
                        })
                    else
                        CollectIron()
                    end
                end
            end
        else
            if nearMine then
                nearMine = false
                lib.hideTextUI()
            end
        end
    end
end)

function CollectIron()
    isCollecting = true
    lib.hideTextUI()

    local ped = PlayerPedId()

    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HAMMERING", 0, true)

    if lib.progressBar({
        duration = Config.IronMine.collectTime,
        label = 'Raccogliendo ferro...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        }
    }) then
        ClearPedTasks(ped)
        TriggerServerEvent('iron:collect')
        lastCollect = GetGameTimer()

        lib.notify({
            title = 'Miniera',
            description = 'Ferro raccolto con successo!',
            type = 'success'
        })
    else
        ClearPedTasks(ped)
        lib.notify({
            title = 'Miniera',
            description = 'Raccolta annullata!',
            type = 'error'
        })
    end

    isCollecting = false
end
