Citizen.CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()

        if IsPedArmed(ped, 7) then
            local weapon = GetSelectedPedWeapon(ped)

            if weapon ~= GetHashKey("WEAPON_UNARMED") then
                SetPedInfiniteAmmoClip(ped, true)
            end
        end
    end
end)
