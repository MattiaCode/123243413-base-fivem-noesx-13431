Citizen.CreateThread(function()
    while true do
        Wait(1000)

        local ped = PlayerPedId()

        SetPedArmour(ped, 100)

        local maxHealth = GetEntityMaxHealth(ped)
        local currentHealth = GetEntityHealth(ped)

        if currentHealth < maxHealth then
            SetEntityHealth(ped, currentHealth)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        DisableControlAction(0, 323, true)
    end
end)
