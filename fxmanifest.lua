fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'SanTy'
description 'Evidence Bag system for QBCore using qb-inventory & ox_lib'
version '1.0.0'

shared_scripts { '@ox_lib/init.lua', 'config.lua' }

client_scripts { 'client.lua' }
server_scripts { '@oxmysql/lib/MySQL.lua', 'server.lua' }

dependencies {
    'qb-core',
    'qb-inventory',
    'ox_lib'
}
