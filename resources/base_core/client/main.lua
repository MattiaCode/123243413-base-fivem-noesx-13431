local isFirstSpawn = true
local playerLoaded = false

AddEventHandler('playerSpawned', function()
    if isFirstSpawn then
        isFirstSpawn = false
        TriggerEvent('base:initialSpawn')
    end
end)

RegisterNetEvent('base:initialSpawn')
AddEventHandler('base:initialSpawn', function()
    DoScreenFadeOut(500)
    Wait(500)

    SpawnPlayer()

    Wait(1000)
    DoScreenFadeIn(1000)
    playerLoaded = true
end)

function SpawnPlayer()
    local model = GetHashKey(Config.DefaultModel)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)

    local ped = PlayerPedId()
    SetPedDefaultComponentVariation(ped)

    SetEntityCoords(ped, Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z, false, false, false, true)
    SetEntityHeading(ped, Config.SpawnPoint.heading)

    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true)
    SetEntityInvincible(ped, false)

    NetworkResurrectLocalPlayer(Config.SpawnPoint.x, Config.SpawnPoint.y, Config.SpawnPoint.z, Config.SpawnPoint.heading, true, false)

    ClearPedTasksImmediately(ped)
    RemoveAllPedWeapons(ped, true)
    ClearPlayerWantedLevel(PlayerId())
end

function IsPlayerInSafeZone()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - Config.SafeZone.coords)
    return distance <= Config.SafeZone.radius
end

exports('IsPlayerInSafeZone', IsPlayerInSafeZone)
exports('SpawnPlayer', SpawnPlayer)
