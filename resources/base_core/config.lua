Config = {}

Config.SpawnPoint = {
    x = -1037.61,
    y = -2737.73,
    z = 20.17,
    heading = 330.0
}

Config.MainSafeZone = {
    coords = vector3(-1037.61, -2737.73, 20.17),
    radius = 30.0,
    markerType = 1,
    markerColor = {r = 0, g = 255, b = 0, a = 100}
}

Config.TeleportPed = {
    model = 'a_m_m_business_01',
    coords = vector4(-1035.0, -2735.0, 20.17, 150.0)
}

Config.ShopPed = {
    model = 's_m_m_shopkeep_01',
    coords = vector4(-1040.0, -2735.0, 20.17, 270.0)
}

Config.StoragePed = {
    model = 's_m_m_armoured_01',
    coords = vector4(-1030.0, -2735.0, 20.17, 90.0)
}

Config.TeleportLocations = {
    {
        label = '707',
        coords = vector3(707.0, -1000.0, 24.0),
        radius = 25.0,
        type = 'safe',
        color = 'green'
    },
    {
        label = '593',
        coords = vector3(593.0, -1200.0, 28.0),
        radius = 25.0,
        type = 'safe',
        color = 'green'
    },
    {
        label = 'Grove Street',
        coords = vector3(-52.0, -1823.0, 26.0),
        radius = 25.0,
        type = 'safe',
        color = 'green'
    },
    {
        label = 'Sandy Shores',
        coords = vector3(1850.0, 3700.0, 33.0),
        radius = 25.0,
        type = 'safe',
        color = 'green'
    },
    {
        label = 'Paleto Bay',
        coords = vector3(-200.0, 6200.0, 31.0),
        radius = 25.0,
        type = 'safe',
        color = 'green'
    }
}

Config.RedZones = {
    {
        label = 'Zona PVP Nord',
        points = {
            vector2(100.0, 200.0),
            vector2(150.0, 200.0),
            vector2(150.0, 250.0),
            vector2(100.0, 250.0)
        },
        minZ = 20.0,
        maxZ = 50.0
    },
    {
        label = 'Zona PVP Sud',
        points = {
            vector2(-100.0, -100.0),
            vector2(-50.0, -100.0),
            vector2(-50.0, -50.0),
            vector2(-100.0, -50.0)
        },
        minZ = 10.0,
        maxZ = 40.0
    },
    {
        label = 'Arena di Combattimento',
        points = {
            vector2(500.0, 500.0),
            vector2(600.0, 500.0),
            vector2(600.0, 600.0),
            vector2(500.0, 600.0)
        },
        minZ = 25.0,
        maxZ = 55.0
    }
}

Config.RespawnTimer = 20

Config.StartingItems = {
    {name = 'pistol_mk2', count = 1, metadata = {ammo = 9999}},
    {name = 'bandage', count = 10},
    {name = 'backpack', count = 1},
    {name = 'money', count = 50000}
}

Config.ShopItems = {
    {name = 'pistol_mk2', label = 'Pistola MK2', price = 5000},
    {name = 'smg', label = 'SMG', price = 8000},
    {name = 'rifle', label = 'Fucile', price = 12000},
    {name = 'bandage', label = 'Benda', price = 100},
    {name = 'water', label = 'Acqua', price = 50},
    {name = 'bread', label = 'Pane', price = 50},
    {name = 'phone', label = 'Telefono', price = 500},
    {name = 'backpack', label = 'Zaino', price = 1000}
}

Config.RadioAnimations = {
    {label = 'Animazione 1 - Spalla', dict = 'random@arrests', anim = 'generic_radio_chatter'},
    {label = 'Animazione 2 - Petto', dict = 'cellphone@', anim = 'cellphone_call_listen_base'},
    {label = 'Animazione 3 - Orecchio', dict = 'anim@amb@casino@hangout@oc_strip@oc_str_05@', anim = 'wank_loop_a_stripper_a'},
}
