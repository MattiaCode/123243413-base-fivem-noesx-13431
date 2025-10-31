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

Config.TeleportLocations = {
    {
        label = '707',
        coords = vector3(707.0, -1000.0, 24.0),
        radius = 25.0
    },
    {
        label = '593',
        coords = vector3(593.0, -1200.0, 28.0),
        radius = 25.0
    },
    {
        label = 'Grove Street',
        coords = vector3(-52.0, -1823.0, 26.0),
        radius = 25.0
    },
    {
        label = 'Sandy Shores',
        coords = vector3(1850.0, 3700.0, 33.0),
        radius = 25.0
    },
    {
        label = 'Paleto Bay',
        coords = vector3(-200.0, 6200.0, 31.0),
        radius = 25.0
    }
}

Config.RespawnTimer = 20

Config.StartingItems = {
    {name = 'pistol_mk2', count = 1, metadata = {ammo = 50}},
    {name = 'bandage', count = 10},
    {name = 'backpack', count = 1},
    {name = 'money', count = 50000}
}
