local isDead = false
local deathTimer = 0
local isTimerActive = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()

        if IsEntityDead(ped) and not isDead then
            isDead = true

            if not IsPlayerInSafeZone() then
                isTimerActive = true
                deathTimer = Config.RespawnTimer

                Citizen.CreateThread(function()
                    while deathTimer > 0 and isTimerActive do
                        Wait(1000)
                        deathTimer = deathTimer - 1
                    end

                    if isTimerActive then
                        DoScreenFadeOut(500)
                        Wait(500)

                        SpawnPlayer()

                        Wait(500)
                        DoScreenFadeIn(1000)

                        isDead = false
                        isTimerActive = false
                    end
                end)
            end
        end

        if not IsEntityDead(ped) and isDead then
            isDead = false
            isTimerActive = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if isTimerActive and deathTimer > 0 then
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(0.5, 0.5)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString("Respawn tra: " .. deathTimer .. "s")
            DrawText(0.5, 0.9)
        end
    end
end)
