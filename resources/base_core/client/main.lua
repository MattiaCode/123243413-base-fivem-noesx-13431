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
    local model = GetHashKey('mp_m_freemode_01')

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

    TriggerServerEvent('base:giveStartingItems')
end

function IsPlayerInAnySafeZone()
    local playerCoords = GetEntityCoords(PlayerPedId())

    local distanceMain = #(playerCoords - Config.MainSafeZone.coords)
    if distanceMain <= Config.MainSafeZone.radius then
        return true
    end

    for _, zone in pairs(Config.TeleportLocations) do
        local distance = #(playerCoords - zone.coords)
        if distance <= zone.radius then
            return true
        end
    end

    return false
end

exports('IsPlayerInAnySafeZone', IsPlayerInAnySafeZone)
exports('SpawnPlayer', SpawnPlayer)
