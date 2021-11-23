fx_version 'adamant'
game 'gta5'

author 'HH Framework'
description 'hh_spawner'
version '1.0'

ui_page "html/index.html"

client_script {
 "client/client.lua",
 '@qb-apartments/config.lua'
}

files {
 "html/index.html",
 "html/css/style.css",
 "html/js/script.js",
 "html/img/Map.png",
}


shared_scripts {
    '@qb-core/import.lua',
    'config.lua'
} 