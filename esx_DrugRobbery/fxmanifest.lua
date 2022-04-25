fx_version 'adamant'

game 'gta5'

description 'Esx Drugheist'

version '2.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/cl_esx_drugheist.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/sv_esx_drugheist.lua'
}

dependencies {
	'es_extended'
}
