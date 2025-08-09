fx_version 'cerulean'

game 'gta5'

lua54 'yes'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/mina_1.lua'
	-- 'client/client.lua' 
}

ui_page('client/html/index.html')

files({
    'client/html/index.html',
    'client/html/sounds/pickaxe.ogg',
	'client/html/sounds/breakrock.ogg'
})

shared_script '@ox_lib/init.lua'

dependencies {
	'mysql-async',
}