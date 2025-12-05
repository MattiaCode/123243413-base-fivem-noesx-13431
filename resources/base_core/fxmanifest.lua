fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Custom Server'
description 'Base Core System'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/spawn.lua',
    'client/safezone.lua',
    'client/teleport.lua',
    'client/vehicles.lua',
    'client/weapons.lua',
    'client/health.lua',
    'client/redzones.lua',
    'client/deathbag.lua',
    'client/shop.lua',
    'client/storage.lua',
    'client/radio.lua'
}

server_scripts {
    'server/main.lua',
    'server/deathbag.lua',
    'server/shop.lua'
}
