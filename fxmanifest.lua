fx_version "adamant"
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
description 'jsfour updated'
lua54 'on'

shared_scripts {
    '@ox_lib/init.lua',
	'shared/*.lua'
}

ui_page 'html/index.html'

server_script {
	'server/*.lua'
}

client_script {
	'client/*.lua'
}

files {
	'html/index.html',
	'html/assets/images/blindfold.png',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
}
