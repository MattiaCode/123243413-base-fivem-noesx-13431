fx_version 'cerulean'
game 'gta5'

author 'Custom Server'
description 'OX Inventory Custom - No ESX'
version '1.0.0'

shared_scripts {
    'config.lua',
    'data/items.lua'
}

server_scripts {
    'server/main.lua',
    'server/inventory.lua'
}

client_scripts {
    'client/main.lua',
    'client/inventory.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/script.js'
}
