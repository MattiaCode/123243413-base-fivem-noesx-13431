fx_version 'cerulean'
game 'gta5'

author 'Custom Server'
description 'Base Core System'
version '1.0.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/spawn.lua',
    'client/safezone.lua',
    'client/customization.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
