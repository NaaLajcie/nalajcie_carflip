fx_version 'cerulean'
game 'gta5'

name "NaLajcie Car Flip"
lua54 'yes'
description "Car Flip"
author "NaLajcie#4754"
version "1.0.0"

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}

dependencies {
	'ox_lib',
	'ox_inventory',
	'es_extended'
}