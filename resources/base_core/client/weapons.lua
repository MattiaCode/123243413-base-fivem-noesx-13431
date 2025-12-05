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

Citizen.CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()

        if IsPedShooting(ped) then
            SetPlayerWeaponDamageModifier(PlayerId(), 1.0)
            SetPlayerMeleeWeaponDamageModifier(PlayerId(), 1.0)
            SetPedSuffersCriticalHits(ped, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        SetWeaponsNoAutoswap(true)
        SetWeaponsNoAutoreload(false)
    end
end)

local weapons = {
    "WEAPON_PISTOL",
    "WEAPON_COMBATPISTOL",
    "WEAPON_PISTOL_MK2",
    "WEAPON_SMG",
    "WEAPON_SMG_MK2",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_ASSAULTRIFLE_MK2",
    "WEAPON_CARBINERIFLE",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_MICROSMG",
    "WEAPON_ASSAULTSMG",
    "WEAPON_GUSENBERG",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_COMBATPDW",
    "WEAPON_APPISTOL",
    "WEAPON_MINISMG"
}

Citizen.CreateThread(function()
    for _, weapon in ipairs(weapons) do
        local hash = GetHashKey(weapon)
        SetWeaponRecoilShakeAmplitude(hash, 0.0)
    end
end)
