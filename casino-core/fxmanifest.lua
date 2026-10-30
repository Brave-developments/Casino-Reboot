fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name 'casino-core'
description 'Casino server-authoritative bet and settlement core'
shared_scripts { '@ox_lib/init.lua', 'config.lua' }
server_scripts { '@oxmysql/lib/MySQL.lua', 'server.lua' }
client_scripts { 'client.lua' }
dependencies { 'qb-core', 'ox_lib', 'oxmysql' }
